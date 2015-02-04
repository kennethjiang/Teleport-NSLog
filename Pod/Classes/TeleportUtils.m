//
//  TeleportConfig.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "TeleportUtils.h"

@implementation TeleportUtils

+ (void)logToStdout:(NSString *)str {

#ifdef TELEPORT_DEBUG

#ifdef DEBUG  //in dev mode, write to stdout so that it won't get redirected
#define LOGOUT stdout
#else       // otherwise, write to stderr so that I can see how it works in real device
#define LOGOUT stderr
#endif

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss:SSS"];
    NSDate *now = [[NSDate alloc] init];
    NSString* timeString = [dateFormat stringFromDate:now];
    fprintf(LOGOUT, "%s - %s\n", [timeString UTF8String], [str UTF8String]);

#endif

}
@end
