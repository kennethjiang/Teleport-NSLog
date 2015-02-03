#import <Foundation/Foundation.h>
#import "TeleportConfig.h"

@interface SimpleHttpForwarder : NSObject

- (id)initWithConfig:(TeleportConfig *)config;

- (void)forwardLog:(NSData *)log forDeviceId:(NSString *)devId;

@end