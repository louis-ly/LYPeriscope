//
//  LYLiveGiftView.h
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYLiveGiftView;
@protocol LYLiveGiftViewDelegate <NSObject>
@optional;
- (void)giftView:(LYLiveGiftView *)giftView rechargeBtnDidClicked:(UIButton *)rechargeBtn;
- (void)giftView:(LYLiveGiftView *)giftView sendBtnDidClickedWithFCount:(NSString *)fCount;
@end

@interface LYLiveGiftView : UIView
@property (nonatomic, weak) id<LYLiveGiftViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *remainCoinLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end
