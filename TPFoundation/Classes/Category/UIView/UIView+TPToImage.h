//
//  UIView+TPToImage.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 屏幕快照 扩展
@interface UIView (TPToImage)

/// view 转为image(截屏效果)
- (nullable UIImage *)tp_snapshotImage;
/// view 转为image(截屏效果，是否在screen更新后)
- (nullable UIImage *)tp_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
@end

NS_ASSUME_NONNULL_END
