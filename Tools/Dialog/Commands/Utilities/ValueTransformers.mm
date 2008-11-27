#import "ValueTransformers.h"
#import "Dialog2.h"

// ===================================================
// = Int Array To Index Path Array Value Transformer =
// ===================================================

@implementation OakIntArrayToIndexPathTransformer
+ (Class)transformedValueClass			{ return [NSArray class]; }
+ (BOOL)allowsReverseTransformation		{ return YES; }

+ (void)load
{
	id transformer = [self new];
	[NSValueTransformer setValueTransformer:transformer forName:@"OakIntArrayToIndexPathTransformer"];
	[transformer release];
}

- (NSIndexPath*)arrayToIndexPath:(NSArray*)anArray
{
	NSIndexPath* indexPath = [[NSIndexPath new] autorelease];
	enumerate(anArray, id index)
		indexPath = [indexPath indexPathByAddingIndex:[index intValue]];
	return indexPath;
}

- (id)transformedValue:(id)value
{
	NSMutableArray* res = [NSMutableArray array];
	enumerate(value, NSArray* intArray)
		[res addObject:[self arrayToIndexPath:intArray]];
	return res;
}

- (NSArray*)indexPathToArray:(NSIndexPath*)anIndexPath
{
	NSMutableArray* array = [NSMutableArray array];
	for(size_t i = 0; i < [anIndexPath length]; ++i)
		[array addObject:[NSNumber numberWithUnsignedInt:[anIndexPath indexAtPosition:i]]];
	return array;
}

- (id)reverseTransformedValue:(id)value
{
	NSMutableArray* array = [NSMutableArray array];
	enumerate(value, NSIndexPath* indexPath)
		[array addObject:[self indexPathToArray:indexPath]];
	return array;
}
@end

// ============================================
// = Int Array To Index Set Value Transformer =
// ============================================

@implementation OakIntArrayToIndexSetTransformer
+ (Class)transformedValueClass			{ return [NSIndexSet class]; }
+ (BOOL)allowsReverseTransformation		{ return YES; }

+ (void)load
{
	id transformer = [self new];
	[NSValueTransformer setValueTransformer:transformer forName:@"OakIntArrayToIndexSetTransformer"];
	[transformer release];
}

- (id)transformedValue:(id)value
{
	NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
	enumerate(value, NSNumber* integer)
		[indexSet addIndex:[integer intValue]];
	return indexSet;
}

- (id)reverseTransformedValue:(id)value
{
	NSMutableArray* array = [NSMutableArray array];
	unsigned int buf[[value count]];
	[(NSIndexSet*)value getIndexes:buf maxCount:[value count] inIndexRange:nil];
	for(unsigned int i = 0; i != [value count]; i++)
		[array addObject:[NSNumber numberWithUnsignedInt:buf[i]]];
	return array;
}
@end

// =============================================
// = #RRGGBB String To Color Value Transformer =
// =============================================

static NSColor* NSColorFromString (NSString* aColor)
{
	if(!aColor || [aColor isEqualToString:@""])
		return nil;

	unsigned int red = 0, green = 0, blue = 0, alpha = 0xFF;
	if(sscanf([aColor UTF8String], "#%02x%02x%02x%02x", &red, &green, &blue, &alpha) < 3)
		return nil;

	return [NSColor colorWithCalibratedRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
}

static NSString* NSStringFromColor (NSColor* aColor)
{
	if(aColor == nil)
		return nil;

	aColor = [aColor colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	if([aColor alphaComponent] != 1.0f)
			return [NSString stringWithFormat:@"#%02X%02X%02X%02X", lroundf(255.0f*[aColor redComponent]), lroundf(255.0f*[aColor greenComponent]), lroundf(255.0f*[aColor blueComponent]), lroundf(255.0f*[aColor alphaComponent])];
	else	return [NSString stringWithFormat:@"#%02X%02X%02X", lroundf(255.0f*[aColor redComponent]), lroundf(255.0f*[aColor greenComponent]), lroundf(255.0f*[aColor blueComponent])];
}

@implementation OakStringToColorTransformer
+ (Class)transformedValueClass				{ return [NSColor class]; }
+ (BOOL)allowsReverseTransformation			{ return YES; }

- (id)transformedValue:(id)value				{ return NSColorFromString(value); }
- (id)reverseTransformedValue:(id)value	{ return NSStringFromColor(value); }

+ (void)load
{
	id transformer = [self new];
	[NSValueTransformer setValueTransformer:transformer forName:@"OakStringToColorTransformer"];
	[transformer release];
}
@end
