#import "SimpleHttpForwarder.h"
#import "zlib.h"

@interface SimpleHttpForwarder() {
    NSString *_aggregatorUrl;
}
@end

@implementation SimpleHttpForwarder

- (id)init
{
    [NSException raise:@"init is not allowed" format:@"Hello Apple, can you give us a better way of preventing wrong init methods being called?"];
    return nil;
    
}

- (id) initWithConfig:(TeleportConfig *)config
{
    if((self = [super init]))
    {
        _aggregatorUrl = config.aggregatorUrl;
        
    }
    return self;
}

- (void)forwardLog:(NSData *)log forDeviceId:(NSString *)devId {
    if ([log length] < 1)
        return;

    [self uploadData:compressData(log) forField:@"file" filename:devId URL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?devid=%@", _aggregatorUrl, devId]] completion:^(BOOL success, NSString *errorMessage) {
        NSLog(@"success = %d; errorMessage = %@", success, errorMessage);
    }];
}

- (void)uploadData:(NSData *)data
                forField:(NSString *)fieldName
          filename:(NSString *)filename
                     URL:(NSURL*)url
              completion:(void (^)(BOOL success, NSString *errorMessage))completion
{
    // configure the request
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set content type
    [request setValue:@"application/zip" forHTTPHeaderField: @"Content-Type"];
    
    // setting the body of the post to the reqeust
    
    [request setHTTPBody:data];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            if (completion)
                completion(FALSE, [NSString stringWithFormat:@"%s: sendAsynchronousRequest error: %@", __FUNCTION__, connectionError]);
            return;
        }
        
        NSError *error = nil;
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (!responseObject)
        {
            if (completion)
                completion(FALSE, [NSString stringWithFormat:@"%s: JSONObjectWithData error=%@", __FUNCTION__, error]);
            return;
        }
        
        BOOL success = [responseObject[@"success"] boolValue];
        NSString *errorMessage = responseObject[@"error"];
        if (completion)
            completion(success, errorMessage);
    }];
}

NSData* compressData(NSData* uncompressedData) {
    if ([uncompressedData length] == 0) return uncompressedData;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in=(Bytef *)[uncompressedData bytes];
    strm.avail_in = (unsigned int)[uncompressedData length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
    
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion
    
    do {
        
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy: 16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (unsigned int)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
        
    } while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength: strm.total_out];
    return [NSData dataWithData:compressed];
}

@end
