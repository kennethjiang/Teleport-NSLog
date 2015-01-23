//
//  Teleport.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "LogRotator.h"
#import "Singleton.h"

@implementation LogRotator

IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(LogRotator)

- (void)rotateIfNeeded
{
    int savedStdErr = dup(STDERR_FILENO);
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *logPath = [cachesDirectory stringByAppendingPathComponent:@"nslogsample.log"];
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    fflush(stderr);
}
@end
