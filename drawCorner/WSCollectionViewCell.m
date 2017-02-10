//
//  WSCollectionViewCell.m
//  drawCorner
//
//  Created by ws on 2016/12/25.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "WSCollectionViewCell.h"
#import "UIView+WS.h"
#import "UIView+EXTENSION.h"

@implementation WSCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews{
    
    self.backgroundColor = [UIColor orangeColor];
    
    int row = 1;
    int col = 1;
    double x = 0.0f;
    double y = 0.0f;
    CGFloat width = self.bounds.size.width / col;
    CGFloat height = self.bounds.size.height / row;
    for (int i = 0; i < row * col; i ++) {
        x = i % col * width;
        y = i / col * height;
        UIImageView *cornerView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        [cornerView setImage:[UIImage imageNamed:@"lena"]];
//        cornerView.layer.cornerRadius = width / 2;
//        cornerView.layer.masksToBounds = true;
        
        [cornerView addCorner:width / 2];
        
//        [cornerView setImage:[self dealImage:[UIImage imageNamed:@"lena"] cornerRadius:width / 2]];
        
        
        
        cornerView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:cornerView];
    }
}

#pragma mark -
#pragma mark - alphaClip
// 自定义裁剪算法
- (UIImage *)dealImage:(UIImage *)img cornerRadius:(CGFloat)c {
    // 1.CGDataProviderRef 把 CGImage 转 二进制流
    
    CGDataProviderRef provider = CGImageGetDataProvider(img.CGImage);
    void *imgData = (void *)CFDataGetBytePtr(CGDataProviderCopyData(provider));
    int width = img.size.width * img.scale;
    int height = img.size.height * img.scale;
    
    // 2.处理 imgData
    //    dealImage(imgData, width, height);
    cornerImage(imgData, width, height, width);
    
    // 3.CGDataProviderRef 把 二进制流 转 CGImage
    CGDataProviderRef pv = CGDataProviderCreateWithData(NULL, imgData, width * height * 4, releaseData);
    CGImageRef content = CGImageCreate(width , height, 8, 32, 4 * width, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast, pv, NULL, true, kCGRenderingIntentDefault);
    UIImage *result = [UIImage imageWithCGImage:content];
    CGDataProviderRelease(pv);      // 释放空间
    CGImageRelease(content);
    
    return result;
}

// 裁剪圆角
void cornerImage(UInt32 *const img, int w, int h, CGFloat cornerRadius) {
    CGFloat c = cornerRadius;
    CGFloat min = w > h ? h : w;
    
    if (c < 0) { c = 0; }
    if (c > min * 0.5) { c = min * 0.5; }
    
    // 左上 y:[0, c), x:[x, c-y)
    for (int y=0; y<c; y++) {
        for (int x=0; x<c-y; x++) {
            UInt32 *p = img + y * w + x;    // p 32位指针，RGBA排列，各8位
            if (isCircle(c, c, c, x, y) == false) {
                *p = 0;
            }
        }
    }
    // 右上 y:[0, c), x:[w-c+y, w)
    int tmp = w-c;
    for (int y=0; y<c; y++) {
        for (int x=tmp+y; x<w; x++) {
            UInt32 *p = img + y * w + x;
            if (isCircle(w-c, c, c, x, y) == false) {
                *p = 0;
            }
        }
    }
    // 左下 y:[h-c, h), x:[0, y-h+c)
    tmp = h-c;
    for (int y=h-c; y<h; y++) {
        for (int x=0; x<y-tmp; x++) {
            UInt32 *p = img + y * w + x;
            if (isCircle(c, h-c, c, x, y) == false) {
                *p = 0;
            }
        }
    }
    // 右下 y~[h-c, h), x~[w-c+h-y, w)
    tmp = w-c+h;
    for (int y=h-c; y<h; y++) {
        for (int x=tmp-y; x<w; x++) {
            UInt32 *p = img + y * w + x;
            if (isCircle(w-c, h-c, c, x, y) == false) {
                *p = 0;
            }
        }
    }
}


// 判断点 (px, py) 在不在圆心 (cx, cy) 半径 r 的圆内
static inline bool isCircle(float cx, float cy, float r, float px, float py) {
    if ((px-cx) * (px-cx) + (py-cy) * (py-cy) > r * r) {
        return false;
    }
    return true;
}

void releaseData(void *info, const void *data, size_t size) {
    free((void *)data);
}


@end
