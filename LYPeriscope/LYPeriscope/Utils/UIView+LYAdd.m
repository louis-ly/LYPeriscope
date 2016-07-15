//
//  UIView+LYAdd.m
//  GlobalLive
//
//  Created by Louis on 16/7/8.
//  Copyright © 2016年 GuanCloud. All rights reserved.
//

#import "UIView+LYAdd.h"

@implementation UIView (LYAdd)

#pragma mark - Get Property
- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)x {
    return self.origin.x;
}

- (CGFloat)y {
    return self.origin.y;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)height {
    return self.size.height;
}

- (CGFloat)width {
    return self.size.width;
}
- (CGFloat)bottom {
    return self.y + self.height;
}

- (CGFloat)right {
    return self.x + self.width;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)centerX {
    return self.center.x;
}

#pragma mark - Set Origin
- (void)setOrigin:(CGPoint)origin {
    self.frame = (CGRect){origin, self.size};
}

- (void)setX:(CGFloat)x {
    [self setOrigin:CGPointMake(x, self.y)];
}

- (void)setY:(CGFloat)y {
    [self setOrigin:CGPointMake(self.x, y)];
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    self.frame = (CGRect){self.origin, size};
}

- (void)setWidth:(CGFloat)width {
    [self setSize:CGSizeMake(width, self.height)];
}

- (void)setHeight:(CGFloat)height {
    [self setSize:CGSizeMake(self.width, height)];
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)showAlert:(NSString *)title message:(NSString *)message {
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

- (void)showAlert:(NSString *)message {
    [self showAlert:@"Error!" message:message];
}

- (void)setLabelShadow {
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        label.shadowColor = [UIColor colorWithWhite:0 alpha:0.6];
        label.shadowOffset = CGSizeMake(1, 1);
    }
}
@end
