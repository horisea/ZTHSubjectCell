//
//  NSArray+CDArrayAdditions.h
//  CDEncryptionAndDecryptionDemo
//
//  Created by Cheng on 14/6/24.
//  Copyright (c) 2014年 Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CDArrayAdditions)

/**
 *  将不可变数组倒序(返回新的数组)
 */
- (NSArray *)cd_reversedArray;

/**
 *  NSArray objectAtIndex:的安全方法，避免数组越界造成的崩溃
 */
- (id)cd_safeObjectAtIndex:(NSUInteger)index;

@end
