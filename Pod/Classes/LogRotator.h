//
//  Teleport.h
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface LogRotator : NSObject

- (void)rotateIfNeeded;

/** Get the singleton instance
 */
+ (LogRotator*) sharedInstance;

@end