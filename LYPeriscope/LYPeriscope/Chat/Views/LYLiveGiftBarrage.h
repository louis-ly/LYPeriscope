//
//  LYLiveGiftBarrage.h
//  GlobalLive
//
//  Created by Louis on 16/7/9.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYLiveGiftBarrageView.h"

@interface LYLiveGiftBarrage : NSObject
- (instancetype)initBarrageToView:(UIView *)toView;
- (void)addBarrageItem:(LYLiveGiftBarrageView *)barrageItem;
- (void)startBarrage;
- (void)stopBarrage;
@end
