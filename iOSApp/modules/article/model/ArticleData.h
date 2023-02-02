//
//  ArtcleData.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import <Foundation/Foundation.h>
#import "StudyData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleData : NSObject

@property(nonatomic,assign) NSInteger aid;
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *userIcon;
@property(nonatomic,copy) NSString *link;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *date;
///主分类
@property(nonatomic,copy) NSString *superChapterName;
///副级分类
@property(nonatomic,copy) NSString *chapterName;
///文章可能是在多级，此字段是文章所属的直系分类ID
@property(nonatomic,assign) NSInteger chapterId;
///封面
@property(nonatomic,copy) NSString *cover;
///简介，副标题
@property(nonatomic,copy) NSString *desc;
///是否置顶
@property(nonatomic,assign) BOOL isTop;
///是否收藏
@property(nonatomic,assign) BOOL collect;

@property(nonatomic,strong) StudyData *studyData;
@end

NS_ASSUME_NONNULL_END
