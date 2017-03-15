//
//  NSArray+CDArrayAdditions.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "NSArray+CDArrayAdditions.h"

@implementation NSArray (CDArrayAdditions)

- (NSArray *)cd_reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return [NSArray arrayWithArray:array];
}

- (id)cd_safeObjectAtIndex:(NSUInteger)index{
    if(self.count == 0) {
        NSLog(@"--- array have no objects ---");
        return (nil);
    }
    if(index > MAX(self.count - 1, 0)) {
        NSLog(@"--- index:%li out of array range ---", (long)index);
        return (nil);
    }
    return ([self objectAtIndex:index]);
}

@end
