//
//  Teleport.h
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import <Foundation/Foundation.h>
#import "TeleportConfig.h"

FOUNDATION_EXPORT BOOL TELEPORT_DEBUG;

@interface Teleport : NSObject

+ (void) appDidLaunch:(TeleportConfig *)config;

@end
