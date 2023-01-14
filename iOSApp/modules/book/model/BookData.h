//
//  BookData.h
//  iOSApp
//
//  Created by 钟达烽 on 2023/1/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookData : NSObject
@property(nonatomic,assign) NSInteger bid;
@property(nonatomic,copy) NSString *author;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *lisense;
@property(nonatomic,copy) NSString *lisenseLink;
@property(nonatomic,copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
