//
//  Teleport.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "LogReaper.h"

static const int TP_LOG_REAPING_TIMER_INTERVAL = 5ull;

@interface LogReaper() {
    LogRotator *_logRotator;
}

@end

@implementation LogReaper

- (id)init
{
    [NSException raise:@"Only initWithLogRotator is allowed" format:@"Hello Apple, can you give us a better way of preventing wrong init methods being called?"];
    return nil;

}

- (id) initWithLogRotator:(LogRotator *)logRotator
{
    if((self = [super init]))
    {
        _logRotator = logRotator;
    }
    return self;
}

- (void)reap
{
    
}

@end
