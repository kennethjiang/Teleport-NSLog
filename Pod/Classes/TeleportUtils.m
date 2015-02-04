//
//  TeleportConfig.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "TeleportUtils.h"

//#define TELEPORT_DEBUG

@implementation TeleportUtils

+ (void)logToStdout:(NSString *)str {

#ifdef TELEPORT_DEBUG

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss:SSS"];
    NSDate *now = [[NSDate alloc] init];
    NSString* timeString = [dateFormat stringFromDate:now];
    fprintf(stdout, "%s - %s\n", [timeString UTF8String], [str UTF8String]);

#endif

}
@end
