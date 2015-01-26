//
//  Teleport.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "Teleport.h"
#import "Singleton.h"
#import "LogRotator.h"
#import "LogReaper.h"


@interface Teleport() {
    LogRotator *_logRotator;
    LogReaper *_logReaper;
}

@end
@implementation Teleport

IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(Teleport)

+ (void)appDidLaunch:(TeleportConfig *)config
{
    [[Teleport sharedInstance] startWithConfig:config];
}

#pragma mark - Lifecycle -

- (id) init
{
    if((self = [super init]))
    {
        _logRotator = [[LogRotator alloc] init];
        _logReaper = [[LogReaper alloc] initWithLogRotator:_logRotator];
    }
    return self;
}

- (void)startWithConfig:(TeleportConfig *)config
{
    [_logRotator startLogRotation];
}

#pragma mark - schedule timer -

- (void)startLogReaping
{
    //Log reaping and log rotation share the same queue because they are not thread-safe
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
//                                                     0, 0, _logRotationQueue);
//    if (timer)
//    {
//        uint64_t interval = TP_LOG_REAPING_TIMER_INTERVAL * NSEC_PER_SEC;
//        uint64_t leeway = 1ull * NSEC_PER_SEC;
//        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
//        dispatch_source_set_event_handler(timer, ^{
//            [_logRotator rotateIfNeeded];
//        });
//        dispatch_resume(timer);
//    }
}
@end
