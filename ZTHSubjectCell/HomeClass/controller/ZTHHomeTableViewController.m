//
//  ZTHHomeTableViewController.m
//  ZTHOmnipotentCell
//
//  Created by 9188 on 2017/3/14.
//  Copyright © 2017年 朱同海. All rights reserved.
//

#import "ZTHHomeTableViewController.h"
#import "NSArray+CDArrayAdditions.h"
#import "NSMutableDictionary+CDMutableDictAdditions.h"
#import "ZTHQuestionModel.h"
#import "ZTHAnswerModel.h"
#import "ZTHDataSourceManager.h"
#import "SCYQuestionAnswerCell.h"

@interface ZTHHomeTableViewController ()

@property (nonatomic, copy) NSArray *questions;

@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *selectedIndexpathArray; // cell的选中答案数组

@property (nonatomic, strong) UIButton *tableFooterButton;

@end

@implementation ZTHHomeTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        self.title = @"首页展示cell的全部类型";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableFooterView = self.tableFooterButton;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ZTHQuestionModel *questionModel = [self.questions cd_safeObjectAtIndex:indexPath.row];
    SCYQuestionAnswerCell *cell = [SCYQuestionAnswerCell questionAnswerCellWithTable:tableView answersCount:questionModel.options.count]; // 自动复用
    [cell setCellDataWithSCYCreditLoginQuestionModel:questionModel andSelectedIndexpathArray:self.selectedIndexpathArray andIndexPath:indexPath]; // 提供接口设置数据
    cell.selectAnswerBlock = ^(NSString *answerString,NSInteger answerCount){
        [weakSelf questionComplentionWithAnswers:answerString andIndexPath:indexPath andAnswerCount:(int)answerCount];
    }; // 事件回调
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTHQuestionModel *questionModel = [self.questions cd_safeObjectAtIndex:indexPath.row];
    NSNumber *rowHeight = [self.heightArray cd_safeObjectAtIndex:(indexPath.row)];
    if (rowHeight) {
        return [rowHeight floatValue];
    }else{
        CGFloat height = [SCYQuestionAnswerCell tableView:tableView rowHeightForObject:questionModel];
        [self.heightArray addObject:@(height)];
        return height;
    }
}
#pragma mark - lazy

/// 问题答案选择后的赋值
- (void)questionComplentionWithAnswers:(NSString *)answer andIndexPath:(NSIndexPath *)indexPath andAnswerCount:(int)answerCount{
    if (self.selectedIndexpathArray.count == 0) { // 为空直接添加
        [self addDataWithIndexPath:indexPath andAnswerCount:answerCount];
    }else{
        NSMutableArray *array = self.selectedIndexpathArray.mutableCopy;
        BOOL isExist = NO;
        for (NSMutableDictionary *dictionary in array) { // 存在删除，再加
            if ([dictionary.allKeys.firstObject isEqualToString:[NSString stringWithFormat:@"%d", (int)indexPath.row]]) {
                isExist = YES;
                [self.selectedIndexpathArray removeObject:dictionary];
                [self addDataWithIndexPath:indexPath andAnswerCount:answerCount];
            }
        }
        if (isExist == NO) {
            [self addDataWithIndexPath:indexPath andAnswerCount:answerCount];
        }
    }
}
/// cell的选中答案数组添加数据
- (void)addDataWithIndexPath:(NSIndexPath *)indexPath andAnswerCount:(int)answerCount{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSString stringWithFormat:@"%d", answerCount] forKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    [self.selectedIndexpathArray addObject:dict];
}

/// 提交答案
- (void)submitQuestionAnswers{
    NSLog(@"答案的集合都在这里了------：%@", self.selectedIndexpathArray); // 答案数组
    if (self.selectedIndexpathArray.count != self.questions.count) {
        NSLog(@"您还有问题没有填写答案哦");
        return;
    }
}
#pragma mark - lazy
- (NSArray *)questions{
    if (!_questions) {
        ZTHDataSourceManager *manager = [[ZTHDataSourceManager alloc] init];
        _questions = [NSArray arrayWithArray:manager.questions];
    }
    return _questions;
}

- (NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}

- (NSMutableArray *)selectedIndexpathArray{
    if (!_selectedIndexpathArray) {
        _selectedIndexpathArray = [[NSMutableArray alloc] init];
    }
    return _selectedIndexpathArray;
}

- (UIButton *)tableFooterButton{
    if (!_tableFooterButton) {
        _tableFooterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 40)];
        _tableFooterButton.backgroundColor = [UIColor cyanColor];
        [_tableFooterButton setTitle:@"提交答案" forState:UIControlStateNormal];
        [_tableFooterButton addTarget:self action:@selector(submitQuestionAnswers) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableFooterButton;
}
@end
