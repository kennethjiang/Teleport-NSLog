//
//  Teleport.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "Teleport.h"
#import "Singleton.h"

@implementation Teleport

IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(Teleport)

+ (void)appDidLaunch:(TeleportConfig *)config
{
    [[Teleport sharedInstance] init:config];
}

#pragma mark - Lifecycle -

- (void)init:(TeleportConfig *)config
{
    int savedStdErr = dup(STDERR_FILENO);
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *logPath = [cachesDirectory stringByAppendingPathComponent:@"nslogsample.log"];
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    fflush(stderr);
    
}
@end
