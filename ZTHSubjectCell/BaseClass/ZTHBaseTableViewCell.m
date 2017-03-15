//
//  ZTHBaseTableViewCell.m
//  ZTHOmnipotentCell
//
//  Created by 9188 on 2017/3/14.
//  Copyright © 2017年 朱同海. All rights reserved.
//

#import "ZTHBaseTableViewCell.h"

@implementation ZTHBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCell];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCell];
    }
    return self;
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
    return 44;
}

- (void)initCell{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    [self setSeparatorInset:UIEdgeInsetsZero];
}

@end
