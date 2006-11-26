/*
   NSArray+CXMRU.m
   
   Created by Chris Thomas on 2006-11-23.
   Copyright 2006 Chris Thomas. All rights reserved.
*/

#import "NSArray+CXMRU.h"

@implementation NSArray (CXMRU)
- (NSArray *)arrayByAddingMostRecentlyUsedObject:(id)object andLimitingCapacityTo:(int)capacity
{
	NSArray *			oldArray = self;
	NSMutableArray *	newArray;
	
	if( oldArray != nil )
	{
		unsigned int	oldIndex;
		
		newArray = [oldArray mutableCopy];
		
		// Already in the array? Move it to latest position
		oldIndex = [newArray indexOfObject:object];
		if( oldIndex != NSNotFound )
		{
			[newArray exchangeObjectAtIndex:oldIndex withObjectAtIndex:0];
		}
		else
		{
			int objectCount;
			
			// Add object, remove oldest object (remove any extra objects that might have snuk in, too)
			[newArray insertObject:object atIndex:0];
			objectCount = [newArray count];
			if( objectCount > capacity )
			{
				NSIndexSet *		indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(capacity, objectCount - capacity)];
				[newArray removeObjectsAtIndexes:indexSet];
			}
		}
	}
	else
	{
		// First time
		newArray = [NSMutableArray arrayWithObject:object];
	}
	
	return newArray;
}

@end
