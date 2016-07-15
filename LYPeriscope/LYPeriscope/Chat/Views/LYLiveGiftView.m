//
//  LYLiveGiftView.m
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import "LYLiveGiftView.h"
#import "LYLiveGiftCell.h"

@interface LYLiveGiftView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *Arr;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end
@implementation LYLiveGiftView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupLiveGiftView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.Arr = [NSArray array];
        self.modelArr = [NSMutableArray array];
        
        [self setupLiveGiftView];
    }
    return self;
}

- (void)setupLiveGiftView {
    _sendBtn.backgroundColor = [UIColor lightGrayColor];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 2 + 35);
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(LYLiveGiftCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(LYLiveGiftCell.class)];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurView.frame = self.bounds;
        [self insertSubview:blurView atIndex:0];
    } else {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
}

- (void)awakeFromNib {
    [self setupLiveGiftView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _pageControl.numberOfPages = 32 / 8;
    return 32;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYLiveGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(LYLiveGiftCell.class) forIndexPath:indexPath];
    [cell.giftCountBtn setTitle:[NSString stringWithFormat:@"%ld", (indexPath.row + 1) * 10] forState:UIControlStateNormal];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth / 4, kScreenWidth / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _sendBtn.backgroundColor = [UIColor colorWithRed:75/255.0 green:211/255.0 blue:179/255.0 alpha:1];
    _sendBtn.enabled = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = (int)scrollView.contentOffset.x / scrollView.width;
}


- (IBAction)sendBtnDidClicked:(UIButton *)sender {
    NSIndexPath *currentIndexPath = [[_collectionView indexPathsForSelectedItems] firstObject];
    if (currentIndexPath) {
        LYLiveGiftCell *item = (LYLiveGiftCell *)[_collectionView cellForItemAtIndexPath:currentIndexPath];
        if ([_delegate respondsToSelector:@selector(giftView:sendBtnDidClickedWithFCount:)]) {
            [_delegate giftView:self sendBtnDidClickedWithFCount:item.giftCountBtn.titleLabel.text];
        }
    }
}

- (IBAction)goToRechargeDidClicked:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(giftView:rechargeBtnDidClicked:)]) {
        [_delegate giftView:self rechargeBtnDidClicked:sender];
    }
    [self showAlert:@"此处应该去往充值"];
}
@end
