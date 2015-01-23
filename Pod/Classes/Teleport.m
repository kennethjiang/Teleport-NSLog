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

@interface Teleport() {
    dispatch_source_t _logRotationTimer;
}

@end
@implementation Teleport

IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(Teleport)

+ (void)appDidLaunch:(TeleportConfig *)config
{
    [[Teleport sharedInstance] init:config];
}

#pragma mark - Lifecycle -

- (void)init:(TeleportConfig *)config
{
    _logRotationTimer = startLogRotation();
}

#pragma mark - schedule timer -

dispatch_source_t startLogRotation()
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                                     0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
    if (timer)
    {
        uint64_t interval = 5ull * NSEC_PER_SEC;
        uint64_t leeway = 1ull * NSEC_PER_SEC;
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
        dispatch_source_set_event_handler(timer, ^{
            [[LogRotator sharedInstance] rotateIfNeeded];
        });
        dispatch_resume(timer);
    }
    return timer;
}

@end
