//
//  ZTUITagView.m
//  iOSApp
//  自适应宽度换行的标签控件
//  Created by 钟达烽 on 2023/1/17.
//

#import "ZTUITagView.h"
#import "ZTUITagChildView.h"

@interface ZTUITagView()<ZTUITagChildViewDelegate>
@end

@implementation ZTUITagView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)initTagViews{
    CGRect frame;
    int lineNumber = 0;
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;

    CGFloat totalWith = 0;
    CGFloat maxWidth = self.frame.size.width;
    
    CGFloat childHeight = 0;
    CGFloat childWidth = 0;

    ZTUITagChildView *tagChild;
    for (int i = 0; i < _dataArray.count; i++) {
        
        tagChild = [[ZTUITagChildView alloc] init];
        tagChild.delegate = self;
        [tagChild setTitle:_dataArray[i]];
        
        childWidth = [tagChild viewWidth] ;
        childHeight = [tagChild viewHeight];
        
        if((totalWith + childWidth) <= maxWidth){
            offsetX = totalWith;
            totalWith += childWidth;
        }else{
            totalWith = childWidth;
            offsetX = 0;//换行
            lineNumber ++;
        }
        offsetY = childHeight * lineNumber;
        frame = CGRectMake(offsetX, offsetY, childWidth, childHeight);
        
        
        tagChild.frame = frame;
        
        [self addSubview:tagChild];
    }
}


/// 设置数据
/// @param dataArray 数据源
- (void)tagViewDataArray:(NSMutableArray<NSString*> *)dataArray{
    _dataArray = dataArray;
    [self initTagViews];
}

#pragma mark - ZTUITabChildViewDelegate
- (void)tagChildViewDidClick:(ZTUITagChildView *)tagChildView{
    _index = [_dataArray indexOfObject:tagChildView.title];
    if([_delegate respondsToSelector:@selector(tagViewDidSelected:index:)]){
        [_delegate tagViewDidSelected:self index:_index];
    }
}

@end
