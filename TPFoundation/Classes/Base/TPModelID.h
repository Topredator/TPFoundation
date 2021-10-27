//
//  TPModelID.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const kTPModelIDKey;
NSString *TPMakeMemoryAddressIdentify(id obj);

@protocol TPModelID <NSObject>
/// 身份标识
- (id)tp_identity;
@end

@interface NSString (TPModelID) <TPModelID>
@end

@interface NSNumber (TPModelID) <TPModelID>
@end

@interface NSValue (TPModelID) <TPModelID>
@end

@interface NSDictionary (TPModelID) <TPModelID>
@end

NS_ASSUME_NONNULL_END
