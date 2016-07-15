//
//  LYLiveViewController.h
//  LYPeriscope
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYLiveDetailHeaderView.h"

typedef NS_ENUM(NSInteger, LYLiveType) {
    LYLiveTypePlayer,
    LYLiveTypeRecord
};

@interface LYLiveViewController : UIViewController <LYLiveDetailHeaderViewDelegate>
@property (nonatomic, assign) LYLiveType liveType;
- (void)showChat;
@end
