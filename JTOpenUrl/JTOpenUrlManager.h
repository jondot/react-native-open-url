#import <UIKit/UIKit.h>
#import "RCTBridgeModule.h"

@interface JTOpenUrlManager : NSObject <RCTBridgeModule>

+ (void)openURL:(NSURL *)url options:(NSDictionary *)options;

@end

