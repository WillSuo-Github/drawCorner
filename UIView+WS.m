//
//  UIView+WS.m
//  drawCorner
//
//  Created by ws on 2016/12/25.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "UIView+WS.h"

@implementation UIView (WS)

- (void)addCorner:(CGFloat)radius{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self drawWithRadius:radius borderWidth:1 backGroundColor:[UIColor redColor] borderColor:[UIColor greenColor]]];
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)drawWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backGroundColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor{
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, radius, radius, radius, M_PI, M_PI / 2 * 3, 0);
    CGContextAddArc(context, width - radius, radius, radius, -M_PI_2, 0, 0);
    CGContextAddArc(context, width - radius, height - radius, radius, 0, M_PI_2, 0);
    CGContextAddArc(context, radius, height - radius, radius, M_PI_2, M_PI, 0);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRelease(context);
    
    return image;
}
@end
