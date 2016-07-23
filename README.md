Teleport-NSLog [![CI Status](http://img.shields.io/travis/kennethjiang/Teleport-NSLog.svg?style=flat)](https://travis-ci.org/kennethjiang/Teleport-NSLog) [![Version](https://img.shields.io/cocoapods/v/Teleport-NSLog.svg?style=flat)](http://cocoadocs.org/docsets/Teleport-NSLog) [![License](https://img.shields.io/cocoapods/l/Teleport-NSLog.svg?style=flat)](http://cocoadocs.org/docsets/Teleport-NSLog) [![Platform](https://img.shields.io/cocoapods/p/Teleport-NSLog.svg?style=flat)](http://cocoadocs.org/docsets/Teleport-NSLog)
===============

*Teleport-NSLog captures NSLog messages when your app runs in user's devices, and sends them to specified backend server.*

When we debug in Xcode, we use NSLog to print a lot of helpful messages to console. It'd be nice if we can access the same info when the app runs in user's devices.

This was what prompted me to write Teleport-NSLog.

Teleport-NSLog re-directs stdout and stderr (where NSLog writes messages to) to backend server (aggregator). SimpleAggregator, which is a basic HTTP-based aggregator, is included in Teleport. Teleport can be easily extended to send to other aggregators such as [logstash](http://logstash.net/), [Fluentd](http://www.fluentd.org/), [Logentries](https://logentries.com), etc.

Installation
--------------

### Podfile

Teleport-NSLog is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

    pod "Teleport-NSLog"

### Aggregator (Backend server)

You can use Linux/Windows/Mac for aggregator. The only requirement is that port 8080 of this server needs to be accessible from the internet.

1. [Install GO](https://golang.org/doc/install). If you are on Ubuntu, simply do:

    `sudo apt-get install golang`

2. Clone Teleport-NSLog to aggregator server:

    `git clone https://github.com/kennethjiang/Teleport-NSLog.git`

3. Compile and run aggegator:

    `cd Teleport-NSLog/SimpleAggregator && go build aggregator.go && ./aggregator`

Security note: if you run this on an internet accessible server, make sure the user it
runs as has restricted read/write permissions to only the `logs` directory.

Usage
--------------

In `AppDelegate.m`

```objective-c
#import <Teleport.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // TELEPORT_DEBUG = YES; // Uncomment this line if you want to redirect NSLog even in Xcode
    [Teleport startWithForwarder:
        [SimpleHttpForwarder forwarderWithAggregatorUrl:@"http://hostname_or_ip_addr.of.your.server:8080/"]
    ];
    // [...]
    return YES;
}
```

Inspecting captured messages
----------------

1. Login to aggregator

2. All captured log files are stored in Teleport-NSLog/SimpleAggregator/logs, by the file name of device UUID.

    `cd Teleport-NSLog/SimpleAggregator/logs && ls`

*Note: Teleport-NSLog will NOT redirect stdout or stderr when the app runs in Xcode, so that NSLog will still write messages to Xcode console window. To override this behavior, uncomment `// TELEPORT_DEBUG = YES;`.

Testing aggregator
----------------

By default, Teleport-NSLog only sends NSLog messages to aggregator when app runs in user's devices. It does nothing when app is launched in Xcode, and therefore the aggregator will receive nothing.

It is a frequently-asked question: how do I test aggregator before I release my app? The answer is: you don't need to because SimpleAggregator just works. But if you insist, or you use your own aggregator, there are 2 options to test aggregator:

- Cut a release build for your app and install it using HockeyApp or similar services, or

- Turn on `TELEPORT_DEBUG = YES;`. Do not forget to turn it off before releasing your app.

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    TELEPORT_DEBUG = YES;
    [Teleport startWithForwarder:
        [SimpleHttpForwarder forwarderWithAggregatorUrl:@"http://hostname_or_ip_addr.of.your.server:8080/"]
    ];
    // [...]
```

Extending Teleport-NSLog
-------------------

Teleport-NSLog can be easily extended to send to other aggregators. To do so, you need to implement `Forwarder` protocol, which is a simple protocol with only 1 required interface:

```objective-c
@protocol Forwarder <NSObject>
@required
- (void)forwardLog:(NSData *)log forDeviceId:(NSString *)devId;
@end
```

You can use `SimpleHttpForwarder` as reference.

How To Contribute
------------------

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Author
-----------------

Kenneth Jiang, kenneth.jiang@gmail.com

License
-----------------

Teleport-NSLog is available under the MIT license. See the LICENSE file for more info.

