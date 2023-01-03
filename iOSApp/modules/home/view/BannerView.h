//
//  BannerView.h
//  iOSApp
//
//  Created by 钟达烽 on 2022/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BannerData;

@interface BannerView : UIView

- (void)updateBanner:(NSMutableArray<BannerData*> *)bannerArray;

@end

NS_ASSUME_NONNULL_END
