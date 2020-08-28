//
//  UIApplication+TPExtend.h
//  TPFoundation
//
//  Created by Topredator on 2020/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// application 扩展
@interface UIApplication (TPExtend)
/// "Documents" folder in this app's sandbox.
@property (nonatomic, strong, readonly) NSURL *tp_documentURL;
@property (nonatomic, copy, readonly) NSString *tp_documentPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *tp_cachesURL;
@property (nonatomic, readonly) NSString *tp_cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *tp_libraryURL;
@property (nonatomic, readonly) NSString *tp_libraryPath;

/// Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString *tp_appBundleName;

/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nullable, nonatomic, readonly) NSString *tp_appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nullable, nonatomic, readonly) NSString *tp_appVersion;

/// Application's Build number. e.g. "123"
@property (nullable, nonatomic, readonly) NSString *tp_appBuildVersion;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t tp_memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float tp_cpuUsage;


+ (BOOL)tp_isAppExtension;

+ (nullable UIApplication *)tp_sharedExtensionApplication;
@end

NS_ASSUME_NONNULL_END
