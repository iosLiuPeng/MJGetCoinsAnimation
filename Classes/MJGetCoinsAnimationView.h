//
//  MJGetCoinsAnimationView.h
//  MJGetCoinsAnimation
//
//  Created by 刘鹏i on 2018/8/2.
//  Copyright © 2018年 wuhan.musjoy. All rights reserved.
//

/*
 需知：
 1.将此视图添加到：动画起点、终点位置共有的父视图上，且与父视图尺寸一致
 2.可以设置视图的userInteractionEnabled，来控制动画期间是否可以响应下层视图事件 (默认为此视图不响应事件)
 3.支持连续多次开始动画，所以有新的动画时，不需要重新创建视图，直接调用开始方法
 4.所有金币动画完成时，会自动将本视图移除
 
 示例：
 MJGetCoinsAnimationView *view = [[MJGetCoinsAnimationView alloc] initWithFrame:self.view.bounds];
 view.imgCoin = [UIImage imageNamed:@"coin"];
 
 [self.view addSubview:view];
 [view startAnimationFrom:_star.center to:_end.center];
 */

#import <UIKit/UIKit.h>

@interface MJGetCoinsAnimationView : UIView
@property (nonatomic, assign) UIImage *imgCoin;          ///< 金币图片

/* 以下参数均有默认值 */
@property (nonatomic, assign) NSInteger coins;          ///< 金币个数
@property (nonatomic, assign) CGSize coinSize;          ///< 金币大小 （默认图片的原始尺寸）
@property (nonatomic, assign) NSTimeInterval duration;  ///< 动画时长
@property (nonatomic, assign) CGSize initialSize;       ///< 金币初始位置范围（中心点范围）

/**
 开始金币入袋动画

 @param fromPoint 金币生成的位置
 @param toPoint 金币最终位置
 */
- (void)startAnimationFrom:(CGPoint)fromPoint to:(CGPoint)toPoint;



@end
