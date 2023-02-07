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
@property(nonatomic,assign) CGFloat itemPadding;//子控件之间的间距

@end

@implementation ZTUITagView

- (instancetype)initWithWidth:(CGFloat)width{
    return [self initWithWidth:width itemPadding:6.0f];
}

- (instancetype)initWithWidth:(CGFloat)width itemPadding:(CGFloat)itemPadding{
    self = [super init];
    if (self) {
        _viewSize = CGSizeZero;
        _viewWidth = width;
        _itemPadding = itemPadding;
    }
    return self;
}

//重新计算大小：自定义View 宽高自适应
- (CGSize)intrinsicContentSize{
    return _viewSize;
}

- (void)initTagViews:(NSArray<NSString*> *)dataArray{
    
    //对比数据
    NSArray<ZTUITagChildView*> *subViews = [self subviews];
    if(subViews.count != 0){
        BOOL dataChange = NO;
        if(dataArray.count == subViews.count){
            for (int i = 0; i < subViews.count; i++) {
                if(![subViews[i].title isEqualToString:dataArray[i]]){
                    dataChange = YES;
                    break;
                }
            }
        }else{
            dataChange = YES;
        }
        if(dataChange){
            //清除旧数据
            [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }else{
            return;
        }
    }

    //添加标签
    ZTUITagChildView *tagChild;
    for (int i = 0; i < dataArray.count; i++) {
        
        tagChild = [[ZTUITagChildView alloc] init];
        tagChild.delegate = self;
        [tagChild setTitle:dataArray[i]];
        
        [self addSubview:tagChild];
    }
}

- (void)layoutTagViews:(BOOL)editing{
    
    NSArray<ZTUITagChildView*> *subViews = [self subviews];
    if(subViews.count == 0) return;
    
    CGRect frame;
    int lineNumber = 0;
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    CGFloat childHeight = 0;
    CGFloat childWidth = 0;
    
    CGFloat height = 0.0;
    CGFloat totalWith = 0;
    CGFloat maxWidth = _viewWidth;//self.frame.size.width;

    ZTUITagChildView *tagChild;
    for (int i = 0; i < subViews.count; i++) {
        
        tagChild = subViews[i];
        tagChild.editing = editing;
        
        childWidth = [tagChild viewWidth];
        childHeight = [tagChild viewHeight];
        
        if((totalWith + _itemPadding + childWidth) <= maxWidth){
            if(totalWith > 0) totalWith += _itemPadding;//第1个不需要间距
            offsetX = totalWith;
            totalWith += childWidth;
        }else{
            totalWith = childWidth;
            offsetX = 0;//换行
            lineNumber ++;
        }
        
        offsetY = childHeight * lineNumber;
        if(lineNumber > 0) offsetY += (lineNumber * _itemPadding);//第1行不需要间距
        
        frame = CGRectMake(offsetX, offsetY, childWidth, childHeight);
        
        height = childHeight * (lineNumber + 1) +(lineNumber * _itemPadding);
        tagChild.frame = frame;
    }
   
    _viewSize = CGSizeMake(maxWidth, height);
    
    // 重新绘制使用自定义计算的大小
    [self invalidateIntrinsicContentSize];
}

/// 设置数据
/// @param dataArray 数据源
- (void)tagViewDataArray:(NSArray<NSString*> *)dataArray{
    _dataArray = dataArray;
    
    [self initTagViews:_dataArray];
    
    [self layoutTagViews:_editing];
}

- (void)setEditing:(BOOL)editing{
    [self layoutTagViews:editing];
}

#pragma mark - ZTUITabChildViewDelegate
- (void)tagChildViewDidClick:(ZTUITagChildView *)tagChildView{
    _index = [_dataArray indexOfObject:tagChildView.title];
    if([_delegate respondsToSelector:@selector(tagViewDidSelected:index:)]){
        [_delegate tagViewDidSelected:self index:_index];
    }
}

-(void)tagChildViewDidEdit:(ZTUITagChildView *)tagChildView{
    _index = [_dataArray indexOfObject:tagChildView.title];
    if([_delegate respondsToSelector:@selector(tagViewDidEdit:index:)]){
        [_delegate tagViewDidEdit:self index:_index];
    }
}

@end
