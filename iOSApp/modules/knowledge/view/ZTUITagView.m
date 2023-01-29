//
//  ZTUITagView.m
//  iOSApp
//  自适应宽度换行的标签控件
//  Created by 钟达烽 on 2023/1/17.
//

#import "ZTUITagView.h"
#import "ZTUITagChildView.h"

@interface ZTUITagView()<ZTUITagChildViewDelegate>
@property(nonatomic,assign) CGSize viewSize;
@property(nonatomic,assign) CGFloat viewWidth;
@end

@implementation ZTUITagView


- (instancetype)initWithWidth:(CGFloat)width{
    self = [super init];
    if (self) {
        _viewSize = CGSizeZero;
        _viewWidth = width;
    }
    return self;
}

//重新计算大小：自定义View 宽高自适应
- (CGSize)intrinsicContentSize{
    return _viewSize;
}

- (void)initTagViews:(NSMutableArray<NSString*> *)dataArray{
    
    NSArray<UIView*> *subViews = [self subviews];
    if(subViews.count > 0) return;

    ZTUITagChildView *tagChild;
    for (int i = 0; i < dataArray.count; i++) {
        
        tagChild = [[ZTUITagChildView alloc] init];
        tagChild.delegate = self;
        [tagChild setTitle:dataArray[i]];
        
        [self addSubview:tagChild];
    }
}

- (void)layoutTagViews{
    
    CGFloat height = 0.0;
    
    CGRect frame;
    int lineNumber = 0;
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;

    CGFloat totalWith = 0;
    CGFloat maxWidth = _viewWidth;//self.frame.size.width;
    CGFloat childHeight = 0;
    CGFloat childWidth = 0;

    NSArray<ZTUITagChildView*> *subViews = [self subviews];
    
    ZTUITagChildView *tagChild;
    for (int i = 0; i < subViews.count; i++) {
        
        tagChild = subViews[i];
        
        childWidth = [tagChild viewWidth];
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
        
        height = childHeight * (lineNumber + 1);
        tagChild.frame = frame;
    }
   
    _viewSize = CGSizeMake(maxWidth, height);
    
    // 重新绘制使用自定义计算的大小
    [self invalidateIntrinsicContentSize];
}

/// 设置数据
/// @param dataArray 数据源
- (void)tagViewDataArray:(NSMutableArray<NSString*> *)dataArray{
    _dataArray = dataArray;
    
    [self initTagViews:_dataArray];
    
    [self layoutTagViews];
}


#pragma mark - ZTUITabChildViewDelegate
- (void)tagChildViewDidClick:(ZTUITagChildView *)tagChildView{
    _index = [_dataArray indexOfObject:tagChildView.title];
    if([_delegate respondsToSelector:@selector(tagViewDidSelected:index:)]){
        [_delegate tagViewDidSelected:self index:_index];
    }
}

@end
