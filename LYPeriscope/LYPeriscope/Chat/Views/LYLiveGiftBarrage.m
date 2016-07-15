//
//  LYLiveGiftBarrage.m
//  GlobalLive
//
//  Created by Louis on 16/7/9.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import "LYLiveGiftBarrage.h"

#define LYLiveTrackOne @"LYLiveTrackOne"
#define LYLiveTrackTwo @"LYLiveTrackTwo"

@interface LYLiveGiftBarrage ()

@property (nonatomic, weak) UIView *toView;
@property (nonatomic, strong) NSMutableArray *barrageArray;
@property (nonatomic, strong) NSMutableDictionary *trackDict;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LYLiveGiftBarrage

- (instancetype)initBarrageToView:(UIView *)toView {
    if (self = [super init]) {
        _toView = toView;
        _barrageArray = [NSMutableArray array];
        _trackDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addTimer {
    if (_timer) [self removeTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(postBarrage)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)postBarrage {
    if (_barrageArray.count == 0) return;
    if (_trackDict.allKeys.count == 2) return;
    
    LYLiveGiftBarrageView *item1 = _trackDict[LYLiveTrackOne];
    
    if (!item1) {
        LYLiveGiftBarrageView *item = [_barrageArray firstObject];
        [_barrageArray removeObjectAtIndex:0];
        [_trackDict setObject:item forKey:LYLiveTrackOne];
        item.y = 64;
        [_toView addSubview:item];
        [item startAnimatingCompleted:^{
            [_trackDict removeObjectForKey:LYLiveTrackOne];
        }];
    }
    
    if (_barrageArray.count == 0) return;
    
    LYLiveGiftBarrageView *item2 = _trackDict[LYLiveTrackTwo];
    if (!item2) {
        LYLiveGiftBarrageView *item = [_barrageArray firstObject];
        [_barrageArray removeObjectAtIndex:0];
        [_trackDict setObject:item forKey:LYLiveTrackTwo];
        item.y = 0;
        [_toView addSubview:item];
        [item startAnimatingCompleted:^{
            [_trackDict removeObjectForKey:LYLiveTrackTwo];
        }];
    }
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)addBarrageItem:(LYLiveGiftBarrageView *)barrageItem {
    [_barrageArray addObject:barrageItem];
}

- (void)startBarrage {
	[self addTimer];
}

- (void)stopBarrage {
	[self removeTimer];
}
@end
