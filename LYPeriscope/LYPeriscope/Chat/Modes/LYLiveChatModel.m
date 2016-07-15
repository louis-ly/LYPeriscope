//
//  LYLiveChatModel.m
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import "LYLiveChatModel.h"

#define LYLiveChatCellNickNameX 36
#define LYLiveChatCellSecondLabelY 25
#define LYLiveChatCellRemainDistance 100

@implementation LYLiveChatModel


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _nickName = dict[LY_nickName];
        _level = dict[LY_level];;
        _content = dict[LY_content];;
        _userId = dict[LY_userId];
        _cellHeight = 25;
        
        NSString *dataType = dict[LY_dataType];
        if ([dataType isEqualToString:LY_EaseMob_MSG_TYPE_BACK] ||
            [dataType isEqualToString:LY_EaseMob_MSG_TYPE_LEAVE]) {
            _isLiveMsg = YES;
            _nickName = @"直播消息";
            _contentColor = [UIColor purpleColor];
        } else if ([dataType isEqualToString:LY_EaseMob_MSG_TYPE_COMMENT]) {
            _contentColor = [UIColor whiteColor];
        } else if ([dataType isEqualToString:LY_EaseMob_MSG_TYPE_GIFT]) {
            _contentColor = [UIColor redColor];
        } else if ([dataType isEqualToString:LY_EaseMob_MSG_TYPE_C_LIKE]) {
            _contentColor = [UIColor yellowColor];
        } else if ([dataType isEqualToString:LY_EaseMob_MSG_TYPE_USER_JOIN]) {
            _contentColor = [UIColor lightGrayColor];
        }
        
        CGFloat nickNameWidth = [[NSString stringWithFormat:@"%@: ", _nickName] boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size.width;
        CGFloat contentWidth = [_content boundingRectWithSize:CGSizeMake(MAXFLOAT, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size.width;
        
        CGFloat contentMaxWidth = kScreenWidth - LYLiveChatCellNickNameX - nickNameWidth - LYLiveChatCellRemainDistance;
        if (contentWidth > contentMaxWidth) {
            _isMoreLine = YES;
            NSUInteger cutLength = contentMaxWidth  * (CGFloat)_content.length / contentWidth;
            _firstContent = [_content substringToIndex:cutLength];
            _secondContent = [_content substringFromIndex:cutLength];
            _secondContentSize = [_secondContent boundingRectWithSize:CGSizeMake(kScreenWidth - LYLiveChatCellRemainDistance - 8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size;
            
            _cellHeight = LYLiveChatCellSecondLabelY + _secondContentSize.height;
        }
        
    }
    return self;
}
@end
