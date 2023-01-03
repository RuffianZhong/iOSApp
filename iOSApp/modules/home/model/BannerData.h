//
//  BannerData.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerData : NSObject

@property(nonatomic,assign) NSInteger bid;
@property(nonatomic,copy) NSString *imagePath;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
