//
//  Teleport.m
//  Pods
//
//  Created by Kenneth on 1/17/15.
//
//

#import "LogRotator.h"
#import "Singleton.h"

const long long TP_MAX_LOG_FILE_SIZE = 10000L;

@interface LogRotator() {
    NSString *_currentLogPath;
}

@end

@implementation LogRotator

IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(LogRotator)

- (id) init
{
    if((self = [super init]))
    {
        _currentLogPath = nil;
    }
    return self;
}

- (void)rotateIfNeeded
{
    if (_currentLogPath == nil) {       //No current log. Create a new one
        [self rotate];
    } else {
        if ([self fileSize:_currentLogPath] > TP_MAX_LOG_FILE_SIZE) {
            [self rotate];
        }
    }
}

- (long long)fileSize:(NSString *)filePath
{
    NSError *attributesError = nil;
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&attributesError];
    
    if (attributesError)
        return -1L;

    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    return [fileSizeNumber longLongValue];
}

- (void)rotate
{
    NSString *logDir = [self ensureLogDir];
    NSString *newFileName = [NSString stringWithFormat:@"%f.log", [[NSDate date] timeIntervalSince1970] * 1000];
    _currentLogPath = [logDir stringByAppendingPathComponent:newFileName];
    freopen([_currentLogPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

- (NSString *)ensureLogDir
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *newDirectory = [cacheDirectory stringByAppendingPathComponent:@"com.teleport.data"];
    
    BOOL isDir = NO;
    NSError *err1;
    NSError *err2;
    if ([[NSFileManager defaultManager] fileExistsAtPath:newDirectory isDirectory:&isDir])
    {
        if (!isDir) {
            [[NSFileManager defaultManager] removeItemAtPath:newDirectory error:&err1];
            [[NSFileManager defaultManager]createDirectoryAtPath:newDirectory withIntermediateDirectories:NO attributes:nil error:&err2];
        }
    }
    else
    {
        [[NSFileManager defaultManager]createDirectoryAtPath:newDirectory withIntermediateDirectories:NO attributes:nil error:&err2];
    }
    if (err1 || err2) {
        NSLog(@"error1: %@\nerror2: %@", err1, err2);
        return nil;
    }
    return newDirectory;
}
@end
