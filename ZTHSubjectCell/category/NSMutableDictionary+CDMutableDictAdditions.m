//
//  NSMutableDictionary+CDMutableDictAdditions.m
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import "NSMutableDictionary+CDMutableDictAdditions.h"

@implementation NSMutableDictionary (CDMutableDictAdditions)

- (void)cd_safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if(!aKey || !anObject) {
        NSLog(@"--- setObject:forKey: key and object must not nil");
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end
