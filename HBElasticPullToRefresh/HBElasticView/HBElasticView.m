//
//  HBElasticView.m
//  HBElasticPullToRefresh
//
//  Created by Beans on 16/8/16.
//  Copyright © 2016年 iceWorks. All rights reserved.
//

#import "HBElasticView.h"

@interface HBElasticView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation HBElasticView

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.fillColor = (__bridge CGColorRef _Nullable)([UIColor redColor]);
//        _shapeLayer.fillColor = (__bridge CGColorRef _Nullable)(self.shapeLayerFillColor);
//        _shapeLayer.strokeColor = (__bridge CGColorRef _Nullable)(self.shapeLayerStrokeColor);
        [self.layer addSublayer:_shapeLayer];
    }
    return _shapeLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
