#ifndef Pods_Singleton_h
#define Pods_Singleton_h

/** Create a "sharedInstance" method with the specified type.
 *
 * @param TYPE The type to return from "sharedInstance".
 */
#define IMPLEMENT_SHARED_INSTANCE(TYPE) \
+ (TYPE*) sharedInstance \
{ \
    static id sharedInstance = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^ \
    { \
        sharedInstance = [[self alloc] init]; \
    }); \
    return sharedInstance; \
}


/** Create an exclusive "sharedInstance" method with the specified type.
 * This will also implement "allocWithZone:" and actively prohibit multiple
 * instances from existing.
 *
 * Note: This won't stop someone from manually creating an instance BEFORE
 * sharedInstance is called, but if that does happen, you'll still see a failed
 * alloc.
 *
 * @param TYPE The type to return from "sharedInstance".
 */
#define IMPLEMENT_EXCLUSIVE_SHARED_INSTANCE(TYPE) \
IMPLEMENT_SHARED_INSTANCE(TYPE) \
 \
+ (id) allocWithZone:(NSZone *)zone \
{ \
    @synchronized(self) \
    { \
        static id singleInstance = nil; \
        if(singleInstance != nil) \
        { \
            NSLog(@"Error: Only one instance allowed. Use [%@ sharedInstance] to access it", self); \
            return nil; \
        } \
        singleInstance = [super allocWithZone:zone]; \
        return singleInstance; \
    } \
}


#endif // Pods_Singleton_h

