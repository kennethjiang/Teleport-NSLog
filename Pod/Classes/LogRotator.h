//
//  Teleport.h
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import <Foundation/Foundation.h>

@interface LogRotator : NSObject

- (void)startLogRotation;

- (NSString *)logDir;   //The directory where all log files will be stored
- (NSString *)currentLogFilePath; //The path of log file that is current in rotation

@end