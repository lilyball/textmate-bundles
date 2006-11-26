// 
//  NSArray+CXMRU.h
//  
//  Created by Chris Thomas on 2006-11-23.
//  Copyright 2006 Chris Thomas. All rights reserved.
// 

@interface NSArray (CXMRU)
// Add object to array, maintaining the array in reverse chronological order, and with a limited total number of array items.
- (NSArray *)arrayByAddingMostRecentlyUsedObject:(id)object andLimitingCapacityTo:(int)capacity;
@end
