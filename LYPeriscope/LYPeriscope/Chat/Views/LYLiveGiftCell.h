//
//  LYLiveGiftCell.h
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYLiveGiftCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UIButton *giftCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *giftTipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;
@end
