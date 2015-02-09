# Teleport [![CI Status](http://img.shields.io/travis/kennethjiang/Teleport.svg?style=flat)](https://travis-ci.org/Kenneth Jiang/Teleport) [![Version](https://img.shields.io/cocoapods/v/Teleport.svg?style=flat)](http://cocoadocs.org/docsets/Teleport) [![License](https://img.shields.io/cocoapods/l/Teleport.svg?style=flat)](http://cocoadocs.org/docsets/Teleport) [![Platform](https://img.shields.io/cocoapods/p/Teleport.svg?style=flat)](http://cocoadocs.org/docsets/Teleport)

*Capture stderr and stdout when your app runs in user's devices, and send it to specified server.*

When we debug in xcode, we use NSLog to print a lot of helpful info to console. It'd be nice if we can access the same info when the app runs in user's devices.

This was what prompted me to write Teleport.

Teleport re-directs stdout and stderr (this is where NSLog writes messages to) to backend server you specified.

## Installation

### Podfile in your iOS project

Teleport is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "Teleport"

### Aggregator (Backend server)

You can use Linux/Windows/Mac for aggregator. The only requirement is that this server needs to be accessible from the internet.

- [Intall GO](https://golang.org/doc/install). If you are on Ubuntu, just do `sudo apt-get install golang`.
- `git clone https://github.com/kennethjiang/Teleport.git`
- `cd Teleport/SimpleAggregator && go build aggregator.go && ./aggregator`

## Usage

In `AppDelegate.m`

```objective-c
#import <Teleport.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // TELEPORT_DEBUG = YES; // Uncomment this line if you want to capture log when debugging it in xcode.
    [Teleport startWithForwarder:
        [SimpleHttpForwarder forwarderWithAggregatorUrl:@"http://hostname_or_ip_addr.of.your.server:8080/"]
    ];
    // [...]
    return YES;
}
```

## Check captured logs

- Login to aggregator
- `cd Teleport/SimpleAggregator/logs`. All captured log files are stored here. By the file name of device UUID

*Note: Teleport will NOT redirect stdout or stderr when the app runs in xcode, so that NSLog will still write messages to xcode console window. To override this behavior, uncomment `// TELEPORT_DEBUG = YES;`.

## How To Contribute

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Kenneth Jiang, kenneth.jiang@gmail.com

## License

Teleport is available under the MIT license. See the LICENSE file for more info.

