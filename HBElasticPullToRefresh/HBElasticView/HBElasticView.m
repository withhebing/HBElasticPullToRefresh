//
//  HBElasticView.m
//  HBElasticPullToRefresh
//
//  Created by Beans on 16/8/16.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

#import "HBElasticView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define minHeight 100

@interface HBElasticView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, assign) CGFloat minimalHeight;

// control point
@property (nonatomic, strong) UIView *centerPoint;
@property (nonatomic, strong) UIView *l1Point;
@property (nonatomic, strong) UIView *l2Point;
@property (nonatomic, strong) UIView *l3Point;
@property (nonatomic, strong) UIView *r1Point;
@property (nonatomic, strong) UIView *r2Point;
@property (nonatomic, strong) UIView *r3Point;

@end

@implementation HBElasticView

#pragma mark - lazy load

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = CGRectMake(0, 0, kScreenW, minHeight);
        _shapeLayer.fillColor = (__bridge CGColorRef _Nullable)([UIColor blueColor]);
//        _shapeLayer.fillColor = (__bridge CGColorRef _Nullable)(self.shapeLayerFillColor);
//        _shapeLayer.strokeColor = (__bridge CGColorRef _Nullable)(self.shapeLayerStrokeColor);
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

- (UIView *)centerPoint {
    if (!_centerPoint) {
        _centerPoint = [[UIView alloc] initWithFrame:CGRectMake(kScreenW * 0.5, minHeight, 3.0, 3.0)];
        _centerPoint.backgroundColor = [UIColor redColor];
        [self addSubview:_centerPoint];
    }
    return _centerPoint;
}

#pragma mark - init

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        //
//        self.shapeLayer.fillColor = (__bridge CGColorRef _Nullable)([UIColor blueColor]);
//        self.centerPoint.backgroundColor = [UIColor redColor];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // your codes
//        self.shapeLayer.fillColor = (__bridge CGColorRef _Nullable)([UIColor blueColor]);
//        self.centerPoint.backgroundColor = [UIColor redColor];

        [self setupShapeLayer];
        [self setupCenterPoint];
        [self setupGuesture];
        [self shapeLayerPath];
    }
    return self;
}

- (void)setupShapeLayer {
    _shapeLayer = [[CAShapeLayer alloc] init];
    _shapeLayer.frame = CGRectMake(0, 0, kScreenW, minHeight);
    _shapeLayer.fillColor = (__bridge CGColorRef _Nullable)([UIColor blueColor]);
    _shapeLayer.strokeColor = (__bridge CGColorRef _Nullable)([UIColor cyanColor]);
    [self.layer addSublayer:_shapeLayer];
}

- (void)setupCenterPoint {
    _centerPoint = [[UIView alloc] initWithFrame:CGRectMake(kScreenW * 0.5, minHeight, 3.0, 3.0)];
    _centerPoint.backgroundColor = [UIColor redColor];
    [self addSubview:_centerPoint];
}

- (void)setupGuesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 跟着触摸点移动
        CGPoint point = [recognizer translationInView:self];
        CGFloat centerPtX = kScreenW * 0.5 + point.x;
        self.minimalHeight = minHeight + point.y;
        CGFloat centerPtY = self.minimalHeight > minHeight ? self.minimalHeight : minHeight;
        self.centerPoint.frame = CGRectMake(centerPtX, centerPtY, 3.0, 3.0);

    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateFailed) {
        // 弹簧效果 恢复原来位置
        [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //
            self.centerPoint.frame = CGRectMake(kScreenW * 0.5, minHeight, 3.0, 3.0);
        } completion:^(BOOL finished) {
            //
        }];
    }
}

- (void)shapeLayerPath {
//    UIBezierPath *shapeLayerPath = [UIBezierPath bezierPath];
//    [shapeLayerPath moveToPoint:CGPointZero];
//    [shapeLayerPath addLineToPoint:CGPointMake(0, self.minimalHeight)];
//    [shapeLayerPath addQuadCurveToPoint:CGPointMake(kScreenW, self.minimalHeight) controlPoint:self.centerPoint.center];
//    [shapeLayerPath addLineToPoint:CGPointMake(kScreenW, 0)];
//    [shapeLayerPath closePath];
//    self.shapeLayer.path = shapeLayerPath.CGPath;

    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(0, 0)];                              // r1点
    [tPath addLineToPoint:CGPointMake(kScreenW, 0)];            // r2点
    [tPath addLineToPoint:CGPointMake(kScreenW, minHeight)];  // r4点
    [tPath addQuadCurveToPoint:CGPointMake(0, minHeight)
                  controlPoint:self.centerPoint.center]; // r3,r4,r5确定的一个弧线
    [tPath closePath];
    self.shapeLayer.path = tPath.CGPath;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
