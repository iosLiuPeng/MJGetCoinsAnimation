//
//  MainViewController.m
//  MJGetCoinsAnimation
//
//  Created by 刘鹏i on 2018/8/3.
//  Copyright © 2018年 wuhan.musjoy. All rights reserved.
//

#import "MainViewController.h"
#import "MJGetCoinsAnimationView.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIImageView *img1;
@property (strong, nonatomic) IBOutlet UIImageView *img2;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickedbtn:(id)sender {
    MJGetCoinsAnimationView *view = [[MJGetCoinsAnimationView alloc] initWithFrame:self.view.bounds];
    view.imgCoin = [UIImage imageNamed:@"coin"];
    
    [self.view addSubview:view];
    
    UIView *img = arc4random() % 2? _img1: _img2;
    [view startAnimationFrom:_btn.center to:img.center];
}

@end
