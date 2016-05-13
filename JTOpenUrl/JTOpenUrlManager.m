
#import <Foundation/Foundation.h>
#import "JTOpenUrlManager.h"
#import "RCTBridge.h"
#import "RCTConvert.h"
#import "RCTEventDispatcher.h"
#import "RCTUtils.h"

NSString *const JTOpenUrlReceived = @"JTOpenUrlReceived";

@implementation JTOpenUrlManager

RCT_EXPORT_MODULE()

@synthesize bridge = _bridge;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setBridge:(RCTBridge *)bridge
{
    _bridge = bridge;
    NSLog(@"JTOpenUrl: registered bridge");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(handleOpenUrlReceived:)
                                          name:JTOpenUrlReceived
                                          object:nil];
}

- (void)handleOpenUrlReceived:(NSNotification *)notification
{
    [_bridge.eventDispatcher sendAppEventWithName:@"openUrlReceived"
                                                body:notification.userInfo];
}

+ (void)openURL:(NSURL *)url options:(NSDictionary *)options
{
    [[NSNotificationCenter defaultCenter] postNotificationName:JTOpenUrlReceived
                                                        object:self
                                                      userInfo:@{@"url" : [url absoluteString], @"options": options}];
}
@end
