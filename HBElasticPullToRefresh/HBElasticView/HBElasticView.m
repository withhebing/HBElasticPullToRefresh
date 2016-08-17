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

@property (nonatomic, strong) UIView *centerPoint;
@property (nonatomic, assign) CGFloat minimalHeight;

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
        self.shapeLayer.fillColor = (__bridge CGColorRef _Nullable)([UIColor blueColor]);
        self.centerPoint.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setupShapeLayer {
    _shapeLayer = [[CAShapeLayer alloc] init];
    _shapeLayer.frame = CGRectMake(0, 0, kScreenW, minHeight);
    _shapeLayer.fillColor = (__bridge CGColorRef _Nullable)([UIColor blueColor]);
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
        CGPoint point = [recognizer translationInView:self];
        CGFloat centerPtX = kScreenW * 0.5 + point.x;
        self.minimalHeight = minHeight + point.y;
        CGFloat centerPtY = self.minimalHeight > minHeight ? self.minimalHeight : minHeight;
        self.centerPoint.frame = CGRectMake(centerPtX, centerPtY, 3.0, 3.0);

    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateFailed) {
        //
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
