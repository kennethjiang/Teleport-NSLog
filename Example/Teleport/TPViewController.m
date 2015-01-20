//
//  TPViewController.m
//  Teleport
//
//  Created by Kenneth Jiang on 01/17/2015.
//  Copyright (c) 2014 Kenneth Jiang. All rights reserved.
//

#import "TPViewController.h"

@interface TPViewController ()

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(writeLog)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)writeLog {
    NSLog(@"here is the log");
}
@end
