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


BOOL TELEPORT_DEBUG = NO;

@interface Teleport() {
    LogRotator *_logRotator;
    LogReaper *_logReaper;
    id <Forwarder> _forwarder;
}

@end
@implementation Teleport

IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(Teleport)

+ (void) startWithForwarder:(id <Forwarder>)forwarder;
{
    Teleport *instance = [Teleport sharedInstance];
    [instance startWithForwarder:forwarder];
}

#pragma mark - Lifecycle -

- (void)startWithForwarder:(id <Forwarder>)forwarder {
    _forwarder = forwarder;

    BOOL shouldTeleport = NO;

    if (TELEPORT_DEBUG) { //turned on teleport we are debugging Teleport
        shouldTeleport = YES;
    }
    else {
#ifndef DEBUG   //Send to backend only when it's in production mode
        shouldTeleport = YES;
#endif
    }
    
    if (shouldTeleport) {
        _logRotator = [[LogRotator alloc] init];
        _logReaper = [[LogReaper alloc] initWithLogRotator:_logRotator AndForwarder:_forwarder];
        
        [_logRotator startLogRotation];
        [_logReaper startLogReaping];
    }
}

@end
