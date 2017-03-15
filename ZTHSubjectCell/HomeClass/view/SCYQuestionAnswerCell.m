//
//  SCYQuestionAnswerCell.m
//  ProvidentFund
//
//  Created by 9188 on 16/9/7.
//  Copyright © 2016年 9188. All rights reserved.
//

#import "SCYQuestionAnswerCell.h"
#import "SCYQuestionAnswerView.h"
#import "NSString+StringSize.h"
#import "ZTHQuestionModel.h"
#import "ZTHAnswerModel.h"
#import "HLayerAddition.h"
#import "HUIView+Category.h"

NSInteger answersCount = 0;// 记录答案的数目
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
static const NSInteger kLeftAndRightMargin = 15;

@interface SCYQuestionAnswerCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) SCYQuestionAnswerView *selectedAnswerButton;

@end

@implementation SCYQuestionAnswerCell
+ (instancetype)questionAnswerCellWithTable:(UITableView *)tableView answersCount:(NSInteger)count{
    NSString *cellidentifier = [NSString stringWithFormat:@"SCYQuestionAnswerCell%ld", (long)count];
    SCYQuestionAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (cell) {// 防止复用，按钮的选中状态为YES
        [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[SCYQuestionAnswerView class]]) {
                SCYQuestionAnswerView *questView = (SCYQuestionAnswerView *)obj;
                if (questView.isSelected == YES) { // 清空选中状态
                    [questView cancelButtonStatusSelected];
                    *stop = YES;
                }
            }
        }];
    }
    
    answersCount = count;
    if (!cell) {
        cell = [[SCYQuestionAnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self createQuestionAnswerView];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat titleLabelWidth = SCREEN_WIDTH - 2 * kLeftAndRightMargin;
    CGSize titleLabeSize = [self.titleLabel.text sizeWithPreferWidth:titleLabelWidth font:[UIFont systemFontOfSize:17]];
    self.titleLabel.frame = CGRectMake(kLeftAndRightMargin, 5, SCREEN_WIDTH - 2 * kLeftAndRightMargin, titleLabeSize.height);
    
    // 设置答案的坐标
    CGFloat questViewY = titleLabeSize.height + 10;
    for (NSInteger i = 0; i < answersCount; i++) {
        __weak SCYQuestionAnswerView *questView = [self viewWithTag:i * 100 + 1000];
        NSString *title = [questView getAnswerLabeltext];
        if (i == 0) {
            questViewY  = questViewY;
        }else{
            // 计算上一个答案的高度
            __weak SCYQuestionAnswerView *previousQuestView = [self viewWithTag:((i-1) * 100 + 1000)];
            NSString *previousTitle = [previousQuestView getAnswerLabeltext];
            CGFloat previousQuestViewHeight = [SCYQuestionAnswerView questionAnswerCell:self rowHeightForObject:previousTitle];
            questViewY  = questViewY + previousQuestViewHeight;
        }
        CGFloat currentQuestViewHeight = [SCYQuestionAnswerView questionAnswerCell:self rowHeightForObject:title];
        questView.frame = CGRectMake(0, questViewY, self.width, currentQuestViewHeight);
    }
}
#pragma mark - public
- (void)setCellDataWithSCYCreditLoginQuestionModel:(ZTHQuestionModel *)questionModel andSelectedIndexpathArray:(NSMutableArray *)selectedIndexpathArray andIndexPath:(NSIndexPath *)indexPath{
    if (!questionModel) {
        return;
    }
    
    // 从选中数组中，找出是否有选中的答案。  有，记录答案的索引
     __block NSString *seletedAnswerCount;
    if (selectedIndexpathArray.count > 0 ) {
        [selectedIndexpathArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSMutableDictionary class]]) {
                NSMutableDictionary *dict = (NSMutableDictionary *)obj;
                if ([dict.allKeys.firstObject isEqualToString:[NSString stringWithFormat:@"%ld", (long)indexPath.row]]) {
                    seletedAnswerCount = dict.allValues.firstObject;
                }
            }
        }];
    }
    // 对答案数据赋值
    self.titleLabel.text = questionModel.questionName;
    for (NSInteger i = 0; i < questionModel.options.count; i++) {
        ZTHAnswerModel *answerModel = questionModel.options[i];
        SCYQuestionAnswerView __weak *questView = [self viewWithTag:i * 100 + 1000];
        if ( seletedAnswerCount.length > 0 ) {// 如果记录数存在，且索引和questView的tag值相等，设置按钮为选中状态
            if ((questView.tag - 1000) * 0.01 + 1 == seletedAnswerCount.intValue) {
                [self.selectedAnswerButton cancelButtonStatusSelected];
                [questView setButtonStatusToBeSelected];
                self.selectedAnswerButton = questView;
            }
        }
        [questView setAnswerLabelTitle:answerModel.value];
    }
}

#pragma mark - private
/// 创建SCYQuestionAnswerView 答案视图
- (void)createQuestionAnswerView{
    for (NSInteger i = 0; i < answersCount; i++) {// 根据answersCount值，循环创建。
        SCYQuestionAnswerView *questView = [[SCYQuestionAnswerView alloc] init];
        questView.tag = i * 100 + 1000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [questView addGestureRecognizer:tap];
//        questView.layer.borderWidth = 1.0f;
//        questView.layer.borderColor = [UIColor redColor].CGColor;
        [self.contentView addSubview:questView];
    }
}

#pragma mark - override
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    ZTHQuestionModel *questionModel = (ZTHQuestionModel *)object;
    CGFloat titleLabelWidth = SCREEN_WIDTH - 2 * kLeftAndRightMargin;
    CGSize titleLabeSize = [questionModel.questionName sizeWithPreferWidth:titleLabelWidth font:[UIFont systemFontOfSize:17]];
    
    CGFloat questViewY = titleLabeSize.height + 5 + 5;
    for (NSInteger i = 0; i < questionModel.options.count; i++) {
        ZTHAnswerModel *answerModel = questionModel.options[i];
        CGFloat questViewHeight = [SCYQuestionAnswerView questionAnswerCell:nil rowHeightForObject:answerModel.value];
        questViewY = questViewY + questViewHeight;
    }
    return questViewY + 5;
}

#pragma mark - event
- (void)tapAction:(UITapGestureRecognizer *)tap{
    SCYQuestionAnswerView *questView = (SCYQuestionAnswerView *)tap.view;
    [self.selectedAnswerButton cancelButtonStatusSelected];
    [questView setButtonStatusToBeSelected];
    self.selectedAnswerButton = questView;
    self.selectAnswerBlock([questView getAnswerLabeltext], (self.selectedAnswerButton.tag - 1000) * 0.01 + 1);
}

#pragma mark - lazy
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.layer.borderWidth = 1.0f;
//        _titleLabel.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _titleLabel;
}

@end
