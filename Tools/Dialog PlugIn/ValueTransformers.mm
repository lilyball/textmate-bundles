#import "ValueTransformers.h"
#import "Dialog.h"

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
