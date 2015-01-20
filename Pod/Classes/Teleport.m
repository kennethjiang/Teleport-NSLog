//
//  Teleport.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "Teleport.h"

@implementation Teleport

+ (void)appDidLaunch:(TeleportConfig *)config
{
    int savedStdErr = dup(STDERR_FILENO);
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *logPath = [cachesDirectory stringByAppendingPathComponent:@"nslogsample.log"];
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    fflush(stderr);
}
@end
