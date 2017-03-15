//
//  SCYQuestionAnswerButton.m
//  ProvidentFund
//
//  Created by 9188 on 16/9/7.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYQuestionAnswerView.h"
#import "NSString+StringSize.h"
#import "HLayerAddition.h"
#import "HUIView+Category.h"

static CGFloat buttonWidthandHeight = 18;
static CGFloat answerLabelFont = 15;
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
static const NSInteger kLeftAndRightMargin = 15;

@interface SCYQuestionAnswerView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *answerLabel;

@end

@implementation SCYQuestionAnswerView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark - private
- (void)createUI{
    [self addSubview:self.button];
    [self addSubview:self.answerLabel];
}
- (void)changeBtnStatus{
    self.button.selected = YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.button.frame = CGRectMake(kLeftAndRightMargin, 8, buttonWidthandHeight, buttonWidthandHeight);
    CGFloat answerLabelWidth = self.right - 2 * kLeftAndRightMargin - buttonWidthandHeight - 10;
    CGSize answerLabelSize = [self.answerLabel.text sizeWithPreferWidth:answerLabelWidth font:[UIFont systemFontOfSize:answerLabelFont]];
    self.answerLabel.frame = CGRectMake(self.button.right + 10, 6, answerLabelWidth, answerLabelSize.height);
}
#pragma mark - public
- (void)setAnswerLabelTitle:(NSString *)title{
    self.answerLabel.text = title;
}

- (void)setButtonStatusToBeSelected{
    self.button.selected = YES;
    self.isSelected = YES;
}
- (void)cancelButtonStatusSelected{
    self.button.selected = NO;
    self.isSelected = NO;
}

- (NSString *)getAnswerLabeltext{
    return self.answerLabel.text;
}
/// 返回该行的高度
+ (CGFloat)questionAnswerCell:(SCYQuestionAnswerCell *)questionAnswerCell rowHeightForObject:(id)object{
    NSString *answer = (NSString *)object;
    CGFloat answerLabelWidth = SCREEN_WIDTH - 2 * kLeftAndRightMargin - buttonWidthandHeight - 10;
    CGSize answerLabelSize = [answer sizeWithPreferWidth:answerLabelWidth font:[UIFont systemFontOfSize:answerLabelFont]];
    return answerLabelSize.height + 16;
}
#pragma mark - lazy
- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setImage:[UIImage imageNamed:@"credit_answer_normal"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"credit_answer_selected"] forState:UIControlStateSelected];
        _button.userInteractionEnabled = NO;
//        _button.layer.borderWidth = 1.0f;
//        _button.layer.borderColor = rgbColor(39, 165, 225).CGColor;
    }
    return _button;
}
- (UILabel *)answerLabel{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc] init];
        _answerLabel.textColor = [UIColor lightGrayColor];
        _answerLabel.font=[UIFont systemFontOfSize:answerLabelFont];
        _answerLabel.numberOfLines = 0;
        _answerLabel.lineBreakMode=NSLineBreakByWordWrapping;

//        _answerLabel.layer.borderWidth = 1.0f;
//        _answerLabel.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _answerLabel;
}
@end
