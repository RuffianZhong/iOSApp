//
//  BookCollectionViewCell.m
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/14.
//

#import "BookCollectionViewCell.h"

@implementation BookCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _imageView = [[UIImageView alloc] initWithFrame:frame];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
}

- (void)setData:(NSString *)data{
    _data = data;
    [_imageView setImageWithURL:data];
}

@end
