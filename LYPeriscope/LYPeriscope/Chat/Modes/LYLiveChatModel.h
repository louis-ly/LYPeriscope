//
//  LYLiveChatModel.h
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LYLiveChatModel : NSObject
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, assign) BOOL isMoreLine;
@property (nonatomic, assign) BOOL isLiveMsg;
@property (nonatomic, copy) NSString *firstContent;
@property (nonatomic, copy) NSString *secondContent;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) CGSize secondContentSize;

@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
