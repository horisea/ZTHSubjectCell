//
//  SCYQuestionAnswerButton.h
//  ProvidentFund
//
//  Created by 9188 on 16/9/7.
//  Copyright © 2016年 9188. All rights reserved.
//  征信每个问题的view

#import <UIKit/UIKit.h>
@class SCYQuestionAnswerCell;
@interface SCYQuestionAnswerView : UIView

@property (nonatomic, assign) BOOL isSelected; // 是否是选中

///  设置文字的标题
- (void)setAnswerLabelTitle:(NSString *)title;

/// button为选中状态
- (void)setButtonStatusToBeSelected;

/// button取消选中状态
- (void)cancelButtonStatusSelected;

/// 获取answerLabel的text
- (NSString *)getAnswerLabeltext;

/// 获取view的高度
+ (CGFloat)questionAnswerCell:(SCYQuestionAnswerCell *)questionAnswerCell rowHeightForObject:(id)object;

@end
