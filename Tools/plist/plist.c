/*
 * plist
 * Kevin Ballard
 *
 * This is a Ruby extension to read/write Cocoa property lists
 * Not surprisingly, it only works on OS X
 *
 * Copyright © 2005, Kevin Ballard
 *
 * Usage:
 * This extension provides a module named OSX::PropertyList
 * This module has two methods:
 *
 * PropertyList::load(obj, format = false)
 *     Takes either an IO stream open for reading or a String object
 *     Returns an object representing the property list
 *
 *     Optionally takes a boolean format argument. If true, the
 *     return value is an array with the second value being
 *     the format of the plist, which can be one of
 *     :xml1, :binary1, or :openstep
 *
 * PropertyList::dump(io, obj, type = :xml1)
 *     Takes an IO stream (open for writing) and an object
 *     Writes the object to the IO stream as a property list
 *     Posible type values are :xml1 and :binary1
 *
 * It also adds a new method to Object:
 *
 * Object#to_plist(type = :xml1)
 *     Returns a string representation of the property list
 *     Possible type values are :xml1 and :binary1
 *
 * It also adds 2 new methods to String:
 *
 * String#blob=(b)
 *     Sets whether the string is a blob
 *
 * String#blob?
 *     Returns whether the string is a blob
 *
 * A blob string is turned into a CFData when dumped
 *
 */

/*
 * Document-class: PropertyList
 *
 * The PropertyList module provides a means of converting a
 * Ruby Object to a Property List.
 *
 * The various Objects that can be converted are the ones
 * with an equivalent in CoreFoundation. This includes: String,
 * Integer, Float, Boolean, Time, Hash, and Array.
 *
 * See also: String#blob?, String#blob=, and Object#to_plist
 */

#include <ruby.h>
#include <st.h>
#include <CoreFoundation/CoreFoundation.h>

// Here's some convenience macros
#ifndef StringValue
#define StringValue(x) do {								\
		if (TYPE(x) != T_STRING) x = rb_str_to_str(x);	\
	} while (0)
#endif

static VALUE mOSX;
static VALUE mPlist;
static VALUE mPlistDeprecated;
static VALUE timeEpoch;
static VALUE ePropertyListError;

static VALUE id_gm;
static VALUE id_plus;
static VALUE id_minus;
static VALUE id_read;
static VALUE id_write;

static VALUE id_xml;
static VALUE id_binary;
static VALUE id_openstep;

static VALUE id_blob;

VALUE convertPropertyListRef(CFPropertyListRef plist);
VALUE convertStringRef(CFStringRef plist);
VALUE convertDictionaryRef(CFDictionaryRef plist);
VALUE convertArrayRef(CFArrayRef plist);
VALUE convertNumberRef(CFNumberRef plist);
VALUE convertBooleanRef(CFBooleanRef plist);
VALUE convertDataRef(CFDataRef plist);
VALUE convertDateRef(CFDateRef plist);
VALUE str_blob(VALUE self);
VALUE str_setBlob(VALUE self, VALUE b);

// Raises a Ruby exception with the given string
void raiseError(CFStringRef error) {
		char *errBuffer = (char *)CFStringGetCStringPtr(error, kCFStringEncodingUTF8);
		int freeBuffer = 0;
		if (!errBuffer) {
			int len = CFStringGetLength(error)*2+1;
			errBuffer = ALLOC_N(char, len);
			Boolean succ = CFStringGetCString(error, errBuffer, len, kCFStringEncodingUTF8);
			if (!succ) {
				CFStringGetCString(error, errBuffer, len, kCFStringEncodingMacRoman);
			}
			freeBuffer = 1;
		}
		rb_raise(ePropertyListError, (char *)errBuffer);
		if (freeBuffer) free(errBuffer);
}

/* call-seq:
 *    PropertyList.method_missing(symbol, [args]) -> result
 *
 * Forwards all method calls to the OSX::PropertyList class after
 * outputting a warning.
 */
VALUE plist_deprecated_method_missing(int argc, VALUE *argv, VALUE self) {
	static bool shownWarning = false;
	if (!shownWarning) {
		fprintf(stderr, "Warning: PropertyList is deprecated. Use OSX::PropertyList instead.\n");
		shownWarning = true;
	}
	VALUE symbol = *argv++; argc--;
	Check_Type(symbol, T_SYMBOL);
	return rb_funcall3(mPlist, SYM2ID(symbol), argc, argv);
}

/* call-seq:
 *    PropertyList.load(obj)         -> object
 *    PropertyList.load(obj, format) -> [object, format]
 *
 * Loads a property list from an IO stream or a String and creates
 * an equivalent Object from it.
 *
 * If +format+ is provided, it returns one of
 * <tt>:xml1</tt>, <tt>:binary1</tt>, or <tt>:openstep</tt>.
 */
VALUE plist_load(int argc, VALUE *argv, VALUE self) {
	VALUE io, retFormat;
	int count = rb_scan_args(argc, argv, "11", &io, &retFormat);
	if (count < 2) retFormat = Qfalse;
	VALUE buffer;
	if (RTEST(rb_respond_to(io, id_read))) {
		// Read from IO
		buffer = rb_funcall(io, id_read, 0);
	} else {
		StringValue(io);
		buffer = io;
	}
	// For some reason, the CFReadStream version doesn't work with input < 6 characters
	// but the CFDataRef version doesn't return format
	// So lets use the CFDataRef version unless format is requested
	CFStringRef error = NULL;
	CFPropertyListRef plist;
	CFPropertyListFormat format;
	if (RTEST(retFormat)) {
		// Format was requested
		// now just in case, if the input is < 6 characters, we will pad it out with newlines
		// we could do this in all cases, but I don't think it will work with binary
		// even though binary shouldn't be < 6 characters
		UInt8 *bytes;
		int len;
		if (RSTRING(buffer)->len < 6) {
			bytes = ALLOC_N(UInt8, 6);
			memset(bytes, '\n', 6);
			MEMCPY(bytes, RSTRING(buffer)->ptr, UInt8, RSTRING(buffer)->len);
			len = 6;
		} else {
			bytes = (UInt8 *)RSTRING(buffer)->ptr;
			len = RSTRING(buffer)->len;
		}
		CFReadStreamRef readStream = CFReadStreamCreateWithBytesNoCopy(kCFAllocatorDefault, bytes, len, kCFAllocatorNull);
		CFReadStreamOpen(readStream);
		plist = CFPropertyListCreateFromStream(kCFAllocatorDefault, readStream, 0, kCFPropertyListImmutable, &format, &error);
		CFReadStreamClose(readStream);
		CFRelease(readStream);
	} else {
		// Format wasn't requested
		CFDataRef data = CFDataCreateWithBytesNoCopy(kCFAllocatorDefault, (const UInt8*)RSTRING(buffer)->ptr, RSTRING(buffer)->len, kCFAllocatorNull);
		plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, data, kCFPropertyListImmutable, &error);
		CFRelease(data);
	}
	if (error) {
		raiseError(error);
		CFRelease(error);
		return Qnil;
	}
	VALUE obj = convertPropertyListRef(plist);
	CFRelease(plist);
	if (RTEST(retFormat)) {
		VALUE ary = rb_ary_new();
		rb_ary_push(ary, obj);
		if (format == kCFPropertyListOpenStepFormat) {
			retFormat = id_openstep;
		} else if (format == kCFPropertyListXMLFormat_v1_0) {
			retFormat = id_xml;
		} else if (format == kCFPropertyListBinaryFormat_v1_0) {
			retFormat = id_binary;
		} else {
			retFormat = rb_intern("unknown");
		}
		rb_ary_push(ary, ID2SYM(retFormat));
		return ary;
	} else {
		return obj;
	}
}

// Maps the property list object to a ruby object
VALUE convertPropertyListRef(CFPropertyListRef plist) {
	CFTypeID typeID = CFGetTypeID(plist);
	if (typeID == CFStringGetTypeID()) {
		return convertStringRef((CFStringRef)plist);
	} else if (typeID == CFDictionaryGetTypeID()) {
		return convertDictionaryRef((CFDictionaryRef)plist);
	} else if (typeID == CFArrayGetTypeID()) {
		return convertArrayRef((CFArrayRef)plist);
	} else if (typeID == CFNumberGetTypeID()) {
		return convertNumberRef((CFNumberRef)plist);
	} else if (typeID == CFBooleanGetTypeID()) {
		return convertBooleanRef((CFBooleanRef)plist);
	} else if (typeID == CFDataGetTypeID()) {
		return convertDataRef((CFDataRef)plist);
	} else if (typeID == CFDateGetTypeID()) {
		return convertDateRef((CFDateRef)plist);
	} else {
		return Qnil;
	}
}

// Converts a CFStringRef to a String
VALUE convertStringRef(CFStringRef plist) {
	CFIndex byteCount;
	CFRange range = CFRangeMake(0, CFStringGetLength(plist));
	CFStringEncoding enc = kCFStringEncodingUTF8;
	Boolean succ = CFStringGetBytes(plist, range, enc, 0, false, NULL, 0, &byteCount);
	if (!succ) {
		enc = kCFStringEncodingMacRoman;
		CFStringGetBytes(plist, range, enc, 0, false, NULL, 0, &byteCount);
	}
	UInt8 *buffer = ALLOC_N(UInt8, byteCount);
	CFStringGetBytes(plist, range, enc, 0, false, buffer, byteCount, NULL);
	VALUE retval = rb_str_new((char *)buffer, (long)byteCount);
	free(buffer);
	return retval;
}

// Converts the keys and values of a CFDictionaryRef
void dictionaryConverter(const void *key, const void *value, void *context) {
	rb_hash_aset((VALUE)context, convertPropertyListRef(key), convertPropertyListRef(value));
}

// Converts a CFDictionaryRef to a Hash
VALUE convertDictionaryRef(CFDictionaryRef plist) {
	VALUE hash = rb_hash_new();
	CFDictionaryApplyFunction(plist, dictionaryConverter, (void *)hash);
	return hash;
}

// Converts the values of a CFArrayRef
void arrayConverter(const void *value, void *context) {
	rb_ary_push((VALUE)context, convertPropertyListRef(value));
}

// Converts a CFArrayRef to an Array
VALUE convertArrayRef(CFArrayRef plist) {
	VALUE array = rb_ary_new();
	CFRange range = CFRangeMake(0, CFArrayGetCount(plist));
	CFArrayApplyFunction(plist, range, arrayConverter, (void *)array);
	return array;
}

// Converts a CFNumberRef to a Number
VALUE convertNumberRef(CFNumberRef plist) {
	if (CFNumberIsFloatType(plist)) {
		double val;
		CFNumberGetValue(plist, kCFNumberDoubleType, &val);
		return rb_float_new(val);
	} else {
#ifdef LL2NUM
		long long val;
		CFNumberGetValue(plist, kCFNumberLongLongType, &val);
		return LL2NUM(val);
#else
		long val;
		CFNumberGetValue(plist, kCFNumberLongType, &val);
		return LONG2NUM(val);
#endif
	}
}

// Converts a CFBooleanRef to a Boolean
VALUE convertBooleanRef(CFBooleanRef plist) {
	if (CFBooleanGetValue(plist)) {
		return Qtrue;
	} else {
		return Qfalse;
	}
}

// Converts a CFDataRef to a String (with blob set to true)
VALUE convertDataRef(CFDataRef plist) {
	const UInt8 *bytes = CFDataGetBytePtr(plist);
	CFIndex len = CFDataGetLength(plist);
	VALUE str = rb_str_new((char *)bytes, (long)len);
	str_setBlob(str, Qtrue);
	return str;
}

// Converts a CFDateRef to a Time
VALUE convertDateRef(CFDateRef plist) {
	CFAbsoluteTime seconds = CFDateGetAbsoluteTime(plist);

	// trunace the time since Ruby's Time object stores it as a 32 bit signed offset from 1970 (undocumented)
	const float min_time = -3124310400.0f;
	const float max_time =  1169098047.0f;
	seconds = seconds < min_time ? min_time : (seconds > max_time ? max_time : seconds);

	return rb_funcall(timeEpoch, id_plus, 1, rb_float_new(seconds));
}

CFPropertyListRef convertObject(VALUE obj);

// Converts a PropertyList object to a string representation
VALUE convertPlistToString(CFPropertyListRef plist, CFPropertyListFormat format) {
	CFWriteStreamRef writeStream = CFWriteStreamCreateWithAllocatedBuffers(kCFAllocatorDefault, kCFAllocatorDefault);
	CFWriteStreamOpen(writeStream);
	CFStringRef error = NULL;
	CFPropertyListWriteToStream(plist, writeStream, format, &error);
	CFWriteStreamClose(writeStream);
	if (error) {
		raiseError(error);
		return Qnil;
	}
	CFDataRef data = CFWriteStreamCopyProperty(writeStream, kCFStreamPropertyDataWritten);
	CFRelease(writeStream);
	VALUE plistData = convertDataRef(data);
	CFRelease(data);
	return plistData;
}

/* call-seq:
 *    PropertyList.dump(io, obj)         -> Integer
 *    PropertyList.dump(io, obj, format) -> Integer
 *
 * Writes the property list representation of +obj+
 * to the IO stream (must be open for writing).
 *
 * +format+ can be one of <tt>:xml1</tt> or <tt>:binary1</tt>.
 *
 * Returns the number of bytes written, or +nil+ if
 * the object could not be represented as a property list
 */
VALUE plist_dump(int argc, VALUE *argv, VALUE self) {
	VALUE io, obj, type;
	int count = rb_scan_args(argc, argv, "21", &io, &obj, &type);
	if (count < 3) {
		type = id_xml;
	} else {
		type = rb_to_id(type);
	}
	if (type != id_xml && type != id_binary && type != id_openstep) {
		rb_raise(rb_eArgError, "Argument 3 must be one of :xml1, :binary1, or :openstep");
		return Qnil;
	}
	if (!RTEST(rb_respond_to(io, id_write))) {
		rb_raise(rb_eArgError, "Argument 1 must be an IO object");
		return Qnil;
	}
	CFPropertyListRef plist = convertObject(obj);
	CFPropertyListFormat format;
	if (type == id_xml) {
		format = kCFPropertyListXMLFormat_v1_0;
	} else if (type == id_binary) {
		format = kCFPropertyListBinaryFormat_v1_0;
	} else if (type == id_openstep) {
		format = kCFPropertyListOpenStepFormat;
	}
	VALUE data = convertPlistToString(plist, format);
	if (NIL_P(data)) {
		return Qnil;
	} else {
		return rb_funcall(io, id_write, 1, data);
	}
}

/* call-seq:
 *    object.to_plist         -> String
 *    object.to_plist(format) -> String
 *
 * Converts the object to a property list representation
 * and returns it as a string.
 *
 * +format+ can be one of <tt>:xml1</tt> or <tt>:binary1</tt>.
 */
VALUE obj_to_plist(int argc, VALUE *argv, VALUE self) {
	VALUE type;
	int count = rb_scan_args(argc, argv, "01", &type);
	if (count < 1) {
		type = id_xml;
	} else {
		type = rb_to_id(type);
	}
	if (type != id_xml && type != id_binary && type != id_openstep) {
		rb_raise(rb_eArgError, "Argument 2 must be one of :xml1, :binary1, or :openstep");
		return Qnil;
	}
	CFPropertyListRef plist = convertObject(self);
	CFPropertyListFormat format;
	if (type == id_xml) {
		format = kCFPropertyListXMLFormat_v1_0;
	} else if (type == id_binary) {
		format = kCFPropertyListBinaryFormat_v1_0;
	} else if (type == id_openstep) {
		format = kCFPropertyListOpenStepFormat;
	}
	VALUE data = convertPlistToString(plist, format);
	CFRelease(plist);
	if (type == id_xml || type == id_binary) {
		str_setBlob(data, Qfalse);
	}
	return data;
}

CFPropertyListRef convertString(VALUE obj);
CFDictionaryRef convertHash(VALUE obj);
CFArrayRef convertArray(VALUE obj);
CFNumberRef convertNumber(VALUE obj);
CFDateRef convertTime(VALUE obj);

// Converts an Object to a CFTypeRef
CFPropertyListRef convertObject(VALUE obj) {
	switch (TYPE(obj)) {
		case T_STRING: return convertString(obj); break;
		case T_HASH: return convertHash(obj); break;
		case T_ARRAY: return convertArray(obj); break;
		case T_FLOAT:
		case T_FIXNUM:
		case T_BIGNUM: return convertNumber(obj); break;
		case T_TRUE: return kCFBooleanTrue; break;
		case T_FALSE: return kCFBooleanFalse; break;
		default: if (rb_obj_is_kind_of(obj, rb_cTime)) return convertTime(obj);
	}
	rb_raise(rb_eArgError, "An object in the argument tree could not be converted");
	return NULL;
}

// Converts a String to a CFStringRef
CFPropertyListRef convertString(VALUE obj) {
	if (RTEST(str_blob(obj))) {
		// convert to CFDataRef
		StringValue(obj);
		CFDataRef data = CFDataCreate(kCFAllocatorDefault, (const UInt8*)RSTRING(obj)->ptr, (CFIndex)RSTRING(obj)->len);
		return data;
	} else {
		// convert to CFStringRef
		StringValue(obj);
		CFStringRef string = CFStringCreateWithBytes(kCFAllocatorDefault, (const UInt8*)RSTRING(obj)->ptr, (CFIndex)RSTRING(obj)->len, kCFStringEncodingUTF8, false);
		if (!string) {
			// try MacRoman
			string = CFStringCreateWithBytes(kCFAllocatorDefault, (const UInt8*)RSTRING(obj)->ptr, (CFIndex)RSTRING(obj)->len, kCFStringEncodingMacRoman, false);
		}
		return string;
	}
}

// Converts the keys and values of a Hash to CFTypeRefs
int iterateHash(VALUE key, VALUE val, VALUE dict) {
	CFPropertyListRef dKey = convertObject(key);
	CFPropertyListRef dVal = convertObject(val);
	CFDictionaryAddValue((CFMutableDictionaryRef)dict, dKey, dVal);
	CFRelease(dKey);
	CFRelease(dVal);
	return ST_CONTINUE;
}

// Converts a Hash to a CFDictionaryREf
CFDictionaryRef convertHash(VALUE obj) {
	CFIndex count = (CFIndex)RHASH(obj)->tbl->num_entries;
	CFMutableDictionaryRef dict = CFDictionaryCreateMutable(kCFAllocatorDefault, count, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	st_foreach(RHASH(obj)->tbl, iterateHash, (VALUE)dict);
	return dict;
}

// Converts an Array to a CFArrayRef
CFArrayRef convertArray(VALUE obj) {
	CFIndex count = (CFIndex)RARRAY(obj)->len;
	CFMutableArrayRef array = CFArrayCreateMutable(kCFAllocatorDefault, count, &kCFTypeArrayCallBacks);
	int i;
	for (i = 0; i < count; i++) {
		CFPropertyListRef aVal = convertObject(RARRAY(obj)->ptr[i]);
		CFArrayAppendValue(array, aVal);
		CFRelease(aVal);
	}
	return array;
}

// Converts a Number to a CFNumberRef
CFNumberRef convertNumber(VALUE obj) {
	void *valuePtr;
	CFNumberType type;
	switch (TYPE(obj)) {
		case T_FLOAT: {
			double num = NUM2DBL(obj);
			valuePtr = &num;
			type = kCFNumberDoubleType;
			break;
		}
		case T_FIXNUM: {
			int num = NUM2INT(obj);
			valuePtr = &num;
			type = kCFNumberIntType;
			break;
		}
		case T_BIGNUM: {
#ifdef NUM2LL
			long long num = NUM2LL(obj);
			type = kCFNumberLongLongType;
#else
			long num = NUM2LONG(obj);
			type = kCFNumberLongType;
#endif
			valuePtr = &num;
			break;
		}
		default:
			rb_raise(rb_eStandardError, "ERROR: Wrong object type passed to convertNumber");
			return NULL;
	}
	CFNumberRef number = CFNumberCreate(kCFAllocatorDefault, type, valuePtr);
	return number;
}

// Converts a Time to a CFDateRef
CFDateRef convertTime(VALUE obj) {
	VALUE secs = rb_funcall(obj, id_minus, 1, timeEpoch);
	CFDateRef date = CFDateCreate(kCFAllocatorDefault, NUM2DBL(secs));
	return date;
}

/* call-seq:
 *    str.blob? -> Boolean
 *
 * Returns whether or not +str+ is a blob.
 */
VALUE str_blob(VALUE self) {
	VALUE blob = rb_attr_get(self, id_blob);
	if (NIL_P(blob)) {
		return Qfalse;
	} else {
		return blob;
	}
}

/* call-seq:
 *    str.blob = bool -> bool
 *
 * Sets the blob status of +str+.
 */
VALUE str_setBlob(VALUE self, VALUE b) {
	if (TYPE(b) == T_TRUE || TYPE(b) ==  T_FALSE) {
		return rb_ivar_set(self, id_blob, b);
	} else {
		rb_raise(rb_eArgError, "Argument 1 must be true or false");
		return Qnil;
	}
}

/* Bridge to CoreFoundation for reading/writing Property Lists.
 * Only works when CoreFoundation is available.
 */
void Init_plist() {
	mPlistDeprecated = rb_define_module("PropertyList");
	rb_define_module_function(mPlistDeprecated,"method_missing", plist_deprecated_method_missing, -1);
	mOSX = rb_define_module("OSX");
	mPlist = rb_define_module_under(mOSX, "PropertyList");
	rb_define_module_function(mPlist, "load", plist_load, -1);
	rb_define_module_function(mPlist, "dump", plist_dump, -1);
	rb_define_method(rb_cObject, "to_plist", obj_to_plist, -1);
	rb_define_method(rb_cString, "blob?", str_blob, 0);
	rb_define_method(rb_cString, "blob=", str_setBlob, 1);
	ePropertyListError = rb_define_class_under(mOSX, "PropertyListError", rb_eStandardError);
	id_gm = rb_intern("gm");
	timeEpoch = rb_funcall(rb_cTime, id_gm, 1, INT2FIX(2001));
	rb_define_const(mPlist, "EPOCH", timeEpoch);
	id_plus = rb_intern("+");
	id_minus = rb_intern("-");
	id_read = rb_intern("read");
	id_write = rb_intern("write");
	id_xml = rb_intern("xml1");
	id_binary = rb_intern("binary1");
	id_openstep = rb_intern("openstep");
	id_blob = rb_intern("@blob");
}
