//
//  SCYCreditLoginQuestionModel.h
//  ProvidentFund
//
//  Created by 9188 on 16/9/18.
//  Copyright © 2016年 9188. All rights reserved.
//  征信登录问题模型

#import <Foundation/Foundation.h>

@interface ZTHQuestionModel : NSObject
@property (nonatomic, copy) NSString *questionNo;
@property (nonatomic, copy) NSArray  *options;
@property (nonatomic, copy) NSString *questionName;
@end
