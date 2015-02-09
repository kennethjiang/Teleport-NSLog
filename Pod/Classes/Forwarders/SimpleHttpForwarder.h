#import <Foundation/Foundation.h>

@protocol Forwarder <NSObject>
@required
- (void)forwardLog:(NSData *)log forDeviceId:(NSString *)devId;
@end

@interface SimpleHttpForwarder : NSObject <Forwarder>

@property (nonatomic, strong) NSString *aggregatorUrl;

+ (SimpleHttpForwarder *)forwarderWithAggregatorUrl:(NSString *)url;

@end