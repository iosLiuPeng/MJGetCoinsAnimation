//
//  MJGetCoinsAnimationView.h
//  MJGetCoinsAnimation
//
//  Created by 刘鹏i on 2018/8/2.
//  Copyright © 2018年 wuhan.musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJGetCoinsAnimationView : UIView
@property (nonatomic, assign) UIImage imgCoin;          ///< 金币图片

/* 以下参数均有默认值 */
@property (nonatomic, assign) NSInteger coins;          ///< 金币个数
@property (nonatomic, assign) CGSize coinSize;          ///< 金币大小
@property (nonatomic, assign) NSTimeInterval duration;  ///< 动画时长
@property (nonatomic, assign) CGSize initialSize;       ///< 金币初始位置范围（中心点范围）

/**
 开始金币入袋动画

 1.此视图一般作为子视图添加到：动画起点、终点位置视图共有的父视图上
 2.可以设置视图的userInteractionEnabled，来控制动画期间是否可以响应下层视图事件
 
 @param fromPoint 金币生成的位置
 @param toPoint 金币最终位置
 */
- (void)startAnimationFrom:(CGPoint)fromPoint to:(CGPoint)toPoint;
@end
