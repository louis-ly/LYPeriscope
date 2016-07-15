//
//  LYLiveGiftCell.m
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import "LYLiveGiftCell.h"

@interface LYLiveGiftCell ()

@end
@implementation LYLiveGiftCell
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    _selectedImage.hidden = !selected;
}
@end
