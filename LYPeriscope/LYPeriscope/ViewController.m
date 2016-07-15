//
//  ViewController.m
//  LYPeriscope
//
//  Created by Louis on 16/7/13.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "ViewController.h"
#import "LYLiveViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    LYLiveViewController *liveVC = [LYLiveViewController new];
    liveVC.liveType = LYLiveTypePlayer;
    liveVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:liveVC animated:YES completion:nil];
}

@end
