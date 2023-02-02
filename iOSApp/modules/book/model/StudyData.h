//
//  StudyData.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudyData : NSObject
///表ID
@property(nonatomic,assign) NSInteger sid;
///教程ID
@property(nonatomic,assign) NSInteger bookId;
///文章ID：章节ID
@property(nonatomic,assign) NSInteger articleId;
///学习进度
@property(nonatomic) CGFloat progress;
///学习时间
@property(nonatomic,assign) NSInteger time;
@end

NS_ASSUME_NONNULL_END
