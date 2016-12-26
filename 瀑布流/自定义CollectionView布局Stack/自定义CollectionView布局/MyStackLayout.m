//
//  MyStackLayout.m
//  自定义CollectionView布局
//
//  Created by 徐生广 on 2016/12/26.
//  Copyright © 2016年 Miss. All rights reserved.
//

//0-1的随机数

#define Random0_1 (arc4random_uniform(100)/100.0)
#import "MyStackLayout.h"

@implementation MyStackLayout
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGSize)collectionViewContentSize{

    return CGSizeMake(500, 500);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];

    }
    return array;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *angles = @[@0, @(-0.1), @(-0.3), @(0.01), @(0.2)];

    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    if (indexPath.item >= 5) {
        attrs.hidden = YES;
    }else
    {
        attrs.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
        //值越大越在上面
        attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
        
    }
    return attrs;
}



@end
