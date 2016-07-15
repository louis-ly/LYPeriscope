//
//  LYMacros.h
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#ifndef LYMacros_h
#define LYMacros_h


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define LY_EaseMob_MSG_TYPE_COMMENT      @"comment"         // 评论
#define LY_EaseMob_MSG_TYPE_C_LIKE       @"commentAndLike"  // 点赞加评论提示
#define LY_EaseMob_MSG_TYPE_LIKE         @"like"            // 点赞动画
#define LY_EaseMob_MSG_TYPE_GIFT         @"gift"            // 礼物
#define LY_EaseMob_MSG_TYPE_LEAVE        @"leave"           // 主播离开一会
#define LY_EaseMob_MSG_TYPE_BACK         @"back"            // 主播回来了
#define LY_EaseMob_MSG_TYPE_USER_JOIN    @"userJoined"      // 有人加入了
#define LY_EaseMob_MSG_TYPE_USER_LEAVE   @"userLeaved"      // 有人离开了
#define LY_EaseMob_MSG_TYPE_END_LIVE     @"endLive"         // 直播结束

#define LY_avatar   @"avatar"
#define LY_nickName @"nickName"
#define LY_content  @"content"
#define LY_giftType @"giftType"
#define LY_level    @"level"
#define LY_userId   @"userId"
#define LY_dataType @"dataType"
#define LY_onlineCount @"onlineCount"
#define LY_coinCount @"coinCount"

// 用户的信息
#define USER_avatar @"default_head"
#define USER_nickName @"Louisly" // [GVUserDefaults standardUserDefaults].nickname
#define USER_userId @"12345" // [GVUserDefaults standardUserDefaults].userid
#define USER_level @"43" // [GVUserDefaults standardUserDefaults].level

#import "UIView+LYAdd.h"
//#import "LYEaseMob.h"

#endif /* LYMacros_h */
