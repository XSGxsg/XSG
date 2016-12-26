

//
//  MyImageCell.m
//  自定义CollectionView布局
//
//  Created by 徐生广 on 2016/12/24.
//  Copyright © 2016年 Miss. All rights reserved.
//

#import "MyImageCell.h"

@interface MyImageCell ()
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;

@end

@implementation MyImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ImageView.layer.borderWidth = 3;
    self.ImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.ImageView.layer.cornerRadius = 3;
    self.ImageView.clipsToBounds = YES;

}
-(void)setImage:(NSString *)image
{
    _image = [image copy];
    self.ImageView.image = [UIImage imageNamed:image];
}
@end
