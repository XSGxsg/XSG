//
//  MyLayout.m
//  自定义CollectionView布局
//
//  Created by 徐生广 on 2016/12/24.
//  Copyright © 2016年 Miss. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout

static const CGFloat MyItemM = 100;

-(instancetype)init
{
    
    //初始化

    if (self = [super init]) {
        
    }
    return self;
}
//当边线改变的时候是否重新布局（只要显示的边界发生改变就重新布局，内部就会重新调用layoutAttributesForElementsInRect 方法获得所有cell的布局属性）
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    return YES;
}
//用来设置ScrollView停止滚动那一刻的位置
#pragma mark --proposedContentOffset 原本ScrollView停止滚动那一刻的位置
#pragma mark --滚动速度

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    //计算出ScrollView最后停留的位置
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    //计算屏幕最中间的X
    CGFloat centerX =proposedContentOffset.x + self.collectionView.frame.size.width *0.5;

    //取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    //遍历所有属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
      if( ABS(attrs.center.x - centerX) < ABS(adjustOffsetX))
      {
          adjustOffsetX = attrs.center.x - centerX;
      }
    }
    
    return CGPointMake(proposedContentOffset.x +adjustOffsetX, proposedContentOffset.y);

}


//一些初始化工作最好在这里工作
-(void)prepareLayout
{

    [super prepareLayout];
    //设置每个cell的尺寸
    self.itemSize = CGSizeMake(MyItemM, MyItemM);
    CGFloat inset = (self.collectionView.frame.size.width - MyItemM) *0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //每一个Cell的（item）都有自己的UICollectionViewLayoutAttributes
    //每一个IndexPath都有自己的UICollectionViewLayoutAttributes
    self.minimumLineSpacing = MyItemM;
    
    // UICollectionViewLayoutAttributes 布局属性
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    
    //取出默认的cell的UICollectionViewlayoutAttributes
   NSArray *array = [super layoutAttributesForElementsInRect:rect];
    //计算屏幕最中间的x
    CGFloat centerX =self.collectionView.contentOffset.x + self.collectionView.frame.size.width *0.5;
    //遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        //不是可见的
        if (!CGRectIntersectsRect(visiableRect, attrs.frame))continue;
        //每一个item的中点X
        CGFloat itemCenterX = attrs.center.x;
        //根据屏幕最中间的距离计算缩放比例
        CGFloat scale = 1 + 0.7 * (1 - (ABS(itemCenterX - centerX)/self.collectionView.frame.size.width));
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}




@end
