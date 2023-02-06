//
//  SearchKeywordData.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/2/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchKeywordData : NSObject
@property(nonatomic,assign) NSInteger kid;
@property(nonatomic,copy) NSString* value;
@property(nonatomic,assign) NSInteger time;
@end

NS_ASSUME_NONNULL_END
