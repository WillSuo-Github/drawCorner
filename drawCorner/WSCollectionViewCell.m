//
//  WSCollectionViewCell.m
//  drawCorner
//
//  Created by ws on 2016/12/25.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "WSCollectionViewCell.h"
#import "UIView+WS.h"

@implementation WSCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews{
    
    self.backgroundColor = [UIColor orangeColor];
    
    int row = 5;
    int col = 5;
    double x = 0.0f;
    double y = 0.0f;
    CGFloat width = self.bounds.size.width / col;
    CGFloat height = self.bounds.size.height / row;
    for (int i = 0; i < row * col; i ++) {
        x = i % col * width;
        y = i / col * height;
        UIImageView *cornerView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        cornerView.layer.borderColor = [UIColor greenColor].CGColor;
        cornerView.layer.borderWidth = 1;
        cornerView.layer.cornerRadius = width / 2;
        cornerView.layer.masksToBounds = true;
//        [cornerView addCorner:width / 2];
        cornerView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:cornerView];
    }
}

@end
