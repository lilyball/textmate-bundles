#include <ruby.h>
#include <Security/Security.h>

static VALUE rb_OSX;
static VALUE rb_Keychain;
static VALUE rb_AuthenticationType;
static VALUE rb_ProtocolType;

// These macros convert the FourCharCode type used for protocol and auth parameters to SecKeychain*
#define FourChar2String(code) (char[5]){(code >> 24) & 0xFF, (code >> 16) & 0xFF, (code >> 8) & 0xFF, code & 0xFF, 0}
#define String2FourChar(string) (string[0] << 24 | string[1] << 16 | string[2] << 8 | string[3])

// Checks that a hash called “data” has the requested key, and calls .to_s on
// the value and stores it in a variable with the same name as the key
// Raises an ArgumentError if it's missing
#define CHECK_FETCH_HASH_KEY(key) \
        VALUE sym_##key = rb_eval_string(":" #key);      \
        if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_##key))    rb_raise(rb_eArgError, #key " required");      \
        VALUE key = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_##key), rb_intern("to_s"), 0);

// Returns a string representation of the status code returned by the SecKeychain* functions
const char *getStatusString(OSStatus status) {
     switch (status) {
         case noErr:                    return "Success";
         case errSecNoDefaultKeychain:  return "No default keychain found";
         case errSecDuplicateItem:      return "Duplicate item";
         case errSecItemNotFound:       return "Not found";
         case errSecDataTooLarge:       return "Too large";
         case errSecAuthFailed:         return "Authorisation failed";
         default:                       return "Unknown status";
     }
}

VALUE internet_password_for(VALUE self, VALUE data) {
    VALUE ret = Qnil;

    CHECK_FETCH_HASH_KEY(account)
    CHECK_FETCH_HASH_KEY(protocol)
    CHECK_FETCH_HASH_KEY(server)

    VALUE sym_auth = rb_eval_string(":auth");
    VALUE auth;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_auth)) {
        auth = 0;
    } else {
        auth = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_auth), rb_intern("to_s"), 0);
        auth = String2FourChar(StringValuePtr(auth));
    }

    VALUE sym_port = rb_eval_string(":port");
    VALUE port;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_port)) {
        port = 0;
    } else {
        port = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_port), rb_intern("to_i"), 0);
        port = NUM2INT(port);
    }

    VALUE sym_path = rb_eval_string(":path");
    VALUE path;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_path)) {
        path = rb_str_new2("");
    } else {
        path = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_path), rb_intern("to_s"), 0);
    }

    char *passwordData    = nil; // will be allocated and filled in by SecKeychainFindGenericPassword
    UInt32 passwordLength = nil;
    
    OSStatus status = SecKeychainFindInternetPassword (
                NULL,                                       // default keychain
                strlen(StringValuePtr(server)),             // length of serverName
                StringValuePtr(server),                     // serverName
                0,                                          // length of domain
                NULL,                                       // no domain
                strlen(StringValuePtr(account)),            // length of account name
                StringValuePtr(account),                    // account name
                strlen(StringValuePtr(path)),               // length of path
                StringValuePtr(path),                       // path
                port,                                       // ignore port
                String2FourChar(StringValuePtr(protocol)),  // protocol
                auth,
                &passwordLength,
                &passwordData,
                NULL
            );
    if (status == noErr) {
        ((char*)passwordData)[passwordLength] = '\0'; // Should this be necessary?
        ret = rb_str_new2(passwordData);
        SecKeychainItemFreeContent(NULL, passwordData);
    } else if (status == errSecItemNotFound) {
        ret = Qnil;
    } else if (status == errSecAuthFailed) {
        rb_raise(rb_eSecurityError, "Authorisation failed");
    } else {
        rb_raise(rb_eStandardError, getStatusString(status));
    }
    return ret;
}

VALUE set_internet_password_for(VALUE self, VALUE data) {
    VALUE ret = Qfalse;

    CHECK_FETCH_HASH_KEY(account)
    CHECK_FETCH_HASH_KEY(protocol)
    CHECK_FETCH_HASH_KEY(server)
    CHECK_FETCH_HASH_KEY(password)

    VALUE sym_auth = rb_eval_string(":auth");
    VALUE auth;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_auth)) {
        auth = kSecAuthenticationTypeDefault;
    } else {
        auth = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_auth), rb_intern("to_s"), 0);
        auth = String2FourChar(StringValuePtr(auth));
    }

    VALUE sym_port = rb_eval_string(":port");
    VALUE port;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_port)) {
        port = 0;
    } else {
        port = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_port), rb_intern("to_i"), 0);
        port = NUM2INT(port);
    }

    VALUE sym_path = rb_eval_string(":path");
    VALUE path;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_path)) {
        path = rb_str_new2("");
    } else {
        path = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_path), rb_intern("to_s"), 0);
    }

    OSStatus status = SecKeychainAddInternetPassword (
        NULL,                                       // default keychain
        strlen(StringValuePtr(server)),             // length of serverName
        StringValuePtr(server),                     // serverName
        0,                                          // length of domain
        NULL,                                       // no domain
        strlen(StringValuePtr(account)),            // length of account name
        StringValuePtr(account),                    // account name
        strlen(StringValuePtr(path)),               // length of path
        StringValuePtr(path),                       // path
        port,                                       // ignore port
        String2FourChar(StringValuePtr(protocol)),  // protocol
        auth,                                       // auth type
        strlen(StringValuePtr(password)),
        StringValuePtr(password),
        NULL
     );

    if (status == noErr) {
        ret = Qtrue;
    } else if (status == errSecDuplicateItem) {
        // Try updating instead
        SecKeychainItemRef itemRef = nil;

        status = SecKeychainFindInternetPassword (
                    NULL,                                       // default keychain
                    strlen(StringValuePtr(server)),             // length of serverName
                    StringValuePtr(server),                     // serverName
                    0,                                          // length of domain
                    NULL,                                       // no domain
                    strlen(StringValuePtr(account)),            // length of account name
                    StringValuePtr(account),                    // account name
                    strlen(StringValuePtr(path)),               // length of path
                    StringValuePtr(path),                       // path
                    port,                                       // ignore port
                    String2FourChar(StringValuePtr(protocol)),  // protocol
                    auth,
                    nil,
                    nil,
                    &itemRef
                );

        if (status != noErr)
            rb_raise(rb_eStandardError, getStatusString(status));
        
        status = SecKeychainItemModifyAttributesAndData (
                    itemRef,                             // the item reference
                    NULL,                                // no change to attributes
                    strlen(StringValuePtr(password)),    // length of password
                    StringValuePtr(password)             // pointer to password data
            );
        if (status != noErr)
            rb_raise(rb_eStandardError, getStatusString(status));

        ret = Qtrue;
    } else {
        rb_raise(rb_eStandardError, getStatusString(status));
    }

    return ret;
}

VALUE destroy_internet_password_for(VALUE self, VALUE data) {
    CHECK_FETCH_HASH_KEY(account)
    CHECK_FETCH_HASH_KEY(protocol)
    CHECK_FETCH_HASH_KEY(server)

    VALUE sym_auth = rb_eval_string(":auth");
    VALUE auth;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_auth)) {
        auth = 0;
    } else {
        auth = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_auth), rb_intern("to_s"), 0);
        auth = String2FourChar(StringValuePtr(auth));
    }

    VALUE sym_port = rb_eval_string(":port");
    VALUE port;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_port)) {
        port = 0;
    } else {
        port = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_port), rb_intern("to_i"), 0);
        port = NUM2INT(port);
    }

    VALUE sym_path = rb_eval_string(":path");
    VALUE path;

    if (!rb_funcall(data, rb_intern("has_key?"), 1, sym_path)) {
        path = rb_str_new2("");
    } else {
        path = rb_funcall(rb_funcall(data, rb_intern("fetch"), 1, sym_path), rb_intern("to_s"), 0);
    }

    SecKeychainItemRef itemRef = nil;

    OSStatus status = SecKeychainFindInternetPassword (
                NULL,                                       // default keychain
                strlen(StringValuePtr(server)),             // length of serverName
                StringValuePtr(server),                     // serverName
                0,                                          // length of domain
                NULL,                                       // no domain
                strlen(StringValuePtr(account)),            // length of account name
                StringValuePtr(account),                    // account name
                strlen(StringValuePtr(path)),               // length of path
                StringValuePtr(path),                       // path
                port,                                       // ignore port
                String2FourChar(StringValuePtr(protocol)),  // protocol
                auth,
                nil,
                nil,
                &itemRef
            );

    if (status != noErr || !itemRef)
        return Qfalse;

    status = SecKeychainItemDelete(itemRef);

    return status == noErr ? Qtrue : Qfalse;
}

void Init_keychain() {
	rb_OSX = rb_define_module("OSX");
    rb_Keychain = rb_define_module_under(rb_OSX, "Keychain");

    // Add our methods with 1 parameter
    rb_define_module_function(rb_Keychain, "internet_password_for", internet_password_for, 1);
    rb_define_module_function(rb_Keychain, "set_internet_password_for", set_internet_password_for, 1);
    rb_define_module_function(rb_Keychain, "destroy_internet_password_for", destroy_internet_password_for, 1);

    // The below are constants defined in /System/Library/Frameworks/Security.framework/Headers/SecKeychain.h
    rb_AuthenticationType = rb_define_module_under(rb_Keychain, "AuthenticationType");
    rb_define_const(rb_AuthenticationType, "NTLM",          rb_str_new2(FourChar2String(kSecAuthenticationTypeNTLM)));
    rb_define_const(rb_AuthenticationType, "MSN",           rb_str_new2(FourChar2String(kSecAuthenticationTypeMSN)));
    rb_define_const(rb_AuthenticationType, "DPA",           rb_str_new2(FourChar2String(kSecAuthenticationTypeDPA)));
    rb_define_const(rb_AuthenticationType, "RPA",           rb_str_new2(FourChar2String(kSecAuthenticationTypeRPA)));
    rb_define_const(rb_AuthenticationType, "HTTPBasic",     rb_str_new2(FourChar2String(kSecAuthenticationTypeHTTPBasic)));
    rb_define_const(rb_AuthenticationType, "HTTPDigest",    rb_str_new2(FourChar2String(kSecAuthenticationTypeHTTPDigest)));
    rb_define_const(rb_AuthenticationType, "HTMLForm",      rb_str_new2(FourChar2String(kSecAuthenticationTypeHTMLForm)));
    rb_define_const(rb_AuthenticationType, "Default",       rb_str_new2(FourChar2String(kSecAuthenticationTypeDefault)));
    
    rb_ProtocolType = rb_define_module_under(rb_Keychain, "ProtocolType");
    rb_define_const(rb_ProtocolType, "FTP",         rb_str_new2(FourChar2String(kSecProtocolTypeFTP)));
    rb_define_const(rb_ProtocolType, "FTPAccount",  rb_str_new2(FourChar2String(kSecProtocolTypeFTPAccount)));
    rb_define_const(rb_ProtocolType, "HTTP",        rb_str_new2(FourChar2String(kSecProtocolTypeHTTP)));
    rb_define_const(rb_ProtocolType, "IRC",         rb_str_new2(FourChar2String(kSecProtocolTypeIRC)));
    rb_define_const(rb_ProtocolType, "NNTP",        rb_str_new2(FourChar2String(kSecProtocolTypeNNTP)));
    rb_define_const(rb_ProtocolType, "POP3",        rb_str_new2(FourChar2String(kSecProtocolTypePOP3)));
    rb_define_const(rb_ProtocolType, "SMTP",        rb_str_new2(FourChar2String(kSecProtocolTypeSMTP)));
    rb_define_const(rb_ProtocolType, "SOCKS",       rb_str_new2(FourChar2String(kSecProtocolTypeSOCKS)));
    rb_define_const(rb_ProtocolType, "IMAP",        rb_str_new2(FourChar2String(kSecProtocolTypeIMAP)));
    rb_define_const(rb_ProtocolType, "LDAP",        rb_str_new2(FourChar2String(kSecProtocolTypeLDAP)));
    rb_define_const(rb_ProtocolType, "AppleTalk",   rb_str_new2(FourChar2String(kSecProtocolTypeAppleTalk)));
    rb_define_const(rb_ProtocolType, "AFP",         rb_str_new2(FourChar2String(kSecProtocolTypeAFP)));
    rb_define_const(rb_ProtocolType, "Telnet",      rb_str_new2(FourChar2String(kSecProtocolTypeTelnet)));
    rb_define_const(rb_ProtocolType, "SSH",         rb_str_new2(FourChar2String(kSecProtocolTypeSSH)));
    rb_define_const(rb_ProtocolType, "FTPS",        rb_str_new2(FourChar2String(kSecProtocolTypeFTPS)));
    rb_define_const(rb_ProtocolType, "HTTPS",       rb_str_new2(FourChar2String(kSecProtocolTypeHTTPS)));
    rb_define_const(rb_ProtocolType, "HTTPProxy",   rb_str_new2(FourChar2String(kSecProtocolTypeHTTPProxy)));
    rb_define_const(rb_ProtocolType, "HTTPSProxy",  rb_str_new2(FourChar2String(kSecProtocolTypeHTTPSProxy)));
    rb_define_const(rb_ProtocolType, "FTPProxy",    rb_str_new2(FourChar2String(kSecProtocolTypeFTPProxy)));
    rb_define_const(rb_ProtocolType, "SMB",         rb_str_new2(FourChar2String(kSecProtocolTypeSMB)));
    rb_define_const(rb_ProtocolType, "RTSP",        rb_str_new2(FourChar2String(kSecProtocolTypeRTSP)));
    rb_define_const(rb_ProtocolType, "RTSPProxy",   rb_str_new2(FourChar2String(kSecProtocolTypeRTSPProxy)));
    rb_define_const(rb_ProtocolType, "DAAP",        rb_str_new2(FourChar2String(kSecProtocolTypeDAAP)));
    rb_define_const(rb_ProtocolType, "EPPC",        rb_str_new2(FourChar2String(kSecProtocolTypeEPPC)));
    rb_define_const(rb_ProtocolType, "IPP",         rb_str_new2(FourChar2String(kSecProtocolTypeIPP)));
    rb_define_const(rb_ProtocolType, "NNTPS",       rb_str_new2(FourChar2String(kSecProtocolTypeNNTPS)));
    rb_define_const(rb_ProtocolType, "LDAPS",       rb_str_new2(FourChar2String(kSecProtocolTypeLDAPS)));
    rb_define_const(rb_ProtocolType, "TelnetS",     rb_str_new2(FourChar2String(kSecProtocolTypeTelnetS)));
    rb_define_const(rb_ProtocolType, "IMAPS",       rb_str_new2(FourChar2String(kSecProtocolTypeIMAPS)));
    rb_define_const(rb_ProtocolType, "IRCS",        rb_str_new2(FourChar2String(kSecProtocolTypeIRCS)));
    rb_define_const(rb_ProtocolType, "POP3S",       rb_str_new2(FourChar2String(kSecProtocolTypePOP3S)));
}
