//
//  FpsWindow.m
//  learnAsyncDisplayKit
//
//  Created by ws on 2016/11/19.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "FpsViewController.h"

@interface FpsViewController ()
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) UILabel *fpsLabel;
@end

@implementation FpsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setUpSubViews];
}


- (void)setUpSubViews{
    self.fpsLabel = [[UILabel alloc] init];
    self.fpsLabel.frame = CGRectMake(0, 0, 100, self.view.bounds.size.height);
    self.fpsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.fpsLabel];
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;

    NSString *text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    _fpsLabel.text = text;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.fpsLabel.center = self.view.center;
    
}

@end
