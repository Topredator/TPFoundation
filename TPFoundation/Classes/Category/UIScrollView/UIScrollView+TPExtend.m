//
//  UIScrollView+TPExtend.m
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import "UIScrollView+TPExtend.h"
#import "TPFoundationMacro.h"
TPSYNTH_DUMMY_CLASS(UIScrollView_TPExtend)

@implementation UIScrollView (TPExtend)

- (void)tp_scrollToTop {
    [self tp_scrollToTopAnimated:NO];
}
- (void)tp_animatedScrollToTop {
    [self tp_scrollToTopAnimated:YES];
}

- (void)tp_scrollToBottom {
    [self tp_scrollToBottomAnimated:NO];
}
- (void)tp_animatedScrollToBottom {
    [self tp_scrollToBottomAnimated:YES];
}

- (void)tp_scrollToLeft {
    [self tp_scrollToLeftAnimated:NO];
}
- (void)tp_animatedScrollToLeft {
    [self tp_scrollToLeftAnimated:YES];
}

- (void)tp_scrollToRight {
    [self tp_scrollToRightAnimated:NO];
}
- (void)tp_animatedScrollToRight {
    [self tp_scrollToRightAnimated:YES];
}



- (void)tp_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)tp_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)tp_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)tp_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}
@end
