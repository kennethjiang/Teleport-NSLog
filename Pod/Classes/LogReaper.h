//
//  Teleport.h
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import <Foundation/Foundation.h>
#import "LogRotator.h"

@interface LogReaper : NSObject

- (id) initWithLogRotator:(LogRotator *)logRotator;

//  Find all log files out of rotation, forward them to backend, and delete them.
- (void)reap;

@end