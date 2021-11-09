//
//  TPUIPopupMenuConfig.m
//  TPUIKit
//
//  Created by Topredator on 2021/10/20.
//

#import "TPUIPopupMenuConfig.h"
#import "TPUI.h"
@implementation TPUIPopupMenuConfig
- (instancetype)init {
    self = [super init];
    if (self) {
        _textColor                        = [TPUI rgba:51];
        _selectedTextColor            = [TPUI r:41 g:143 b:237];
        
        _textFont                         = [TPUI tp_font:14 weight:FontRegular];
        _selectedTextFont             = [TPUI tp_font:14 weight:FontMedium];
        
        _bgColor                          = UIColor.whiteColor;
        _selectedBgColor               = UIColor.whiteColor;
        
        _selectedIndex                  = 0;
        _rowHeight                       = 44.0;
        _showDivider                    = YES;
        _shieldColor                     = [TPUI rgba:0 alpha:0.1];
    }
    return self;
}
@end
