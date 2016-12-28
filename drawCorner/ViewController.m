//
//  ViewController.m
//  drawCorner
//
//  Created by ws on 2016/12/25.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "ViewController.h"
#import "UIView+WS.h"
#import "WSCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
}

#pragma mark -
#pragma mark - layout
- (void)configSubViews{
    self.view.backgroundColor = [UIColor orangeColor];
    
    _myCollectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collect = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [collect registerClass:[WSCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        collect.delegate = self;
        collect.dataSource = self;
        [self.view addSubview:collect];
        collect;
    });
}


#pragma mark -
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
