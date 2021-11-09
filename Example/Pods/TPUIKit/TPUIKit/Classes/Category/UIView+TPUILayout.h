//
//  UIView+TPUILayout.h
//  TPUIKit
//
//  Created by Topredator on 2021/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TPUILayout)
@property (nonatomic) CGFloat tp_x;
@property (nonatomic) CGFloat tp_y;
@property (nonatomic) CGFloat tp_left;
@property (nonatomic) CGFloat tp_top;
@property (nonatomic) CGFloat tp_right;
@property (nonatomic) CGFloat tp_bottom;
@property (nonatomic) CGFloat tp_width;
@property (nonatomic) CGFloat tp_height;
@property (nonatomic) CGFloat tp_centerX;
@property (nonatomic) CGFloat tp_centerY;
@property (nonatomic) CGPoint tp_origin;
@property (nonatomic) CGSize  tp_size;
@end

NS_ASSUME_NONNULL_END
