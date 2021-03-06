//
//  MJGetCoinsAnimationView.m
//  MJGetCoinsAnimation
//
//  Created by 刘鹏i on 2018/8/2.
//  Copyright © 2018年 wuhan.musjoy. All rights reserved.
//

#import "MJGetCoinsAnimationView.h"

#define AnimationKey @"AnimationKey"

@interface MJGetCoinsAnimationView () <CAAnimationDelegate>
@property (nonatomic, strong) NSMutableDictionary *dictAnimation;///< 进行中的动画 key:animation value:view
@end

@implementation MJGetCoinsAnimationView
#pragma mark - Life Circle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self viewConfig];
    }
    return self;
}

#pragma mark - Subjoin
- (void)viewConfig
{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    
    _dictAnimation = [[NSMutableDictionary alloc] init];
    
    _coins = 20;                // 金币个数
    _duration = 1.5;            // 动画时长
    _coinSize = CGSizeZero;     // 金币大小
    _initialSize = CGSizeMake(80, 40);// 金币初始位置范围
}

#pragma mark - Set & Get
- (void)setImgCoin:(UIImage *)imgCoin
{
    _imgCoin = imgCoin;
    
    if (CGSizeEqualToSize(_coinSize, CGSizeZero) == YES) {
        _coinSize = imgCoin.size;
    }
}

#pragma mark - Public
- (void)startAnimationFrom:(CGPoint)fromPoint to:(CGPoint)toPoint
{
    if (_imgCoin == nil || _duration <= 0 || _coins <= 0) {
        return;
    }
    
    // 创建金币动画
    for (NSInteger i = 0; i < _coins; i++) {

        // 创建初始位置
        CGPoint point = [self initialPositionWithCenter:fromPoint range:_initialSize];
        
        // 金币视图
        UIImageView *imgView = [[UIImageView alloc] initWithImage:_imgCoin];
        imgView.bounds = CGRectMake(0, 0, _coinSize.width, _coinSize.height);
        imgView.center = point;
        [self addSubview:imgView];
        
        // 轨迹
        UIBezierPath *coinPath = [self coinPathWithFrom:fromPoint to:toPoint current:point];
        
        //位移动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        //移动路径
        animation.path = coinPath.CGPath;
        
        NSInteger times = floor(_duration / 2.0 * 100.0);
        NSTimeInterval duration = (arc4random() % times + 1) / 100.0 + _duration / 2.0;
        animation.duration = duration;
        animation.repeatCount = 1;
        animation.calculationMode = kCAAnimationCubic;
        animation.rotationMode = kCAAnimationRotateAuto;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.delegate = self;
    
        NSString *value = [NSString stringWithFormat:@"%p", animation];
        [_dictAnimation setObject:imgView forKey:value];
        [animation setValue:value forKey:AnimationKey];
        [imgView.layer addAnimation:animation forKey:nil];
    }
}

#pragma mark - Private
/// 金币初始位置
- (CGPoint)initialPositionWithCenter:(CGPoint)center range:(CGSize)sizeRange
{
    CGPoint point = center;
    
    NSInteger xRange = floor(sizeRange.width);
    NSInteger yRange = floor(sizeRange.height);
    
    if (xRange && yRange) {
        CGFloat xOffset = arc4random() % xRange + 1 - sizeRange.width / 2.0;
        CGFloat yOffset = arc4random() % yRange + 1 - sizeRange.height / 2.0;
        point = CGPointMake(center.x + xOffset, center.y + yOffset);
    }

    return point;
}

/// 金币运动路径
- (UIBezierPath *)coinPathWithFrom:(CGPoint)fromPoint to:(CGPoint)toPoint current:(CGPoint)point
{
    // 创建运动轨迹
    UIBezierPath *coinPath = [UIBezierPath bezierPath];
    [coinPath moveToPoint:point];
    
    // 控制点
    CGFloat xOffset = (point.x - fromPoint.x) * 3.0;
    CGFloat yOffset = (fromPoint.y - toPoint.y) * 0.2;
    CGPoint controlPoint = CGPointMake(point.x + xOffset, point.y - yOffset);
    
    [coinPath addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    
    return coinPath;
}

#pragma mark - Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *value = [anim valueForKey:AnimationKey];
    
    UIView *view = _dictAnimation[value];
    [_dictAnimation removeObjectForKey:value];
    [view removeFromSuperview];

    if (_dictAnimation.count == 0) {
        [self removeFromSuperview];
    }
}

@end
