//
//  NSMutableDictionary+CDMutableDictAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (CDMutableDictAdditions)

/**
 *  NSMutableDictionary setObject:forKey:的安全方法，避免anObject或aKey为nil时造成的崩溃
 */
- (void)cd_safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
