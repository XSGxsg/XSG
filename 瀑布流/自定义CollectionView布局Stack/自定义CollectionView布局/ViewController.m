//
//  ViewController.m
//  自定义CollectionView布局
//
//  Created by 徐生广 on 2016/12/23.
//  Copyright © 2016年 Miss. All rights reserved.
//

#import "ViewController.h"
#import "MyImageCell.h"
#import "MyStackLayout.h"
#import "MyScoalLayout.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong)NSMutableArray *images;
@property (nonatomic ,strong)UICollectionView *collectionView;
@end

@implementation ViewController

static NSString *const ID =@"image";
//static 防止其他文件访问 const 防止别人改 没有const 只要写esten就可以访问


-(NSArray *)images
{
    if (!_images) {
        self.images = [[NSMutableArray alloc]init];
        for (int i = 1; i<=14; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, w, 200);
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[MyScoalLayout alloc]init]];
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerNib:[UINib nibWithNibName:@"MyImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    [self.view addSubview:collection];
    self.collectionView = collection;
    //UIcollectionViewLayout //最根本的布局（全部自己写）
    // UIcollectionViewFlowLayout 流水布局
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[MyStackLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[MyScoalLayout alloc]init] animated:YES];
    }else
    {
    [self.collectionView setCollectionViewLayout:[[MyStackLayout alloc]init] animated:YES];
    
    }


}


#pragma mark -- <UICollctionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.images.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    //删UI（刷新UI）
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image = self.images[indexPath.item];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
