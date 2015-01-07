//
//  ViewController.m
//  AirplayMirrorApp
//
//  Created by michaelhan on 2014-12-01.
//  Copyright (c) 2014 Michael Han. All rights reserved.
//

#import "ViewController.h"
#import "MPAudioVideoRoutingViewController.h"
#import "MPAVRoutingController.h"
#import "MPAVSystemRoutingController.h"
#import "MPAudioVideoRoutingTableViewController.h"
#import "MPAudioDeviceController.h"
#import "MPAVRoute.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *routingTimer;

- (void)enableMirroring:(NSTimer *)timer;
- (void)disableMirroring:(NSTimer *)timer;

@end

@implementation ViewController

- (void)showPopover:(id)sender {
    MPAudioVideoRoutingViewController *routingViewController = [[MPAudioVideoRoutingViewController alloc] init];
    [self presentViewController:routingViewController
                       animated:YES
                     completion:nil];
}

- (void)handleEnableMirroring:(id)sender {
    if (self.routingTimer) {
        [self.routingTimer invalidate];
    }
    
    self.routingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(enableMirroring:)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)handleDisableMirroring:(id)sender {
    if (self.routingTimer) {
        [self.routingTimer invalidate];
    }
    
    self.routingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(disableMirroring:)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)enableMirroring:(NSTimer *)timer {
    MPAudioVideoRoutingTableViewController *tableViewController = [[MPAudioVideoRoutingTableViewController alloc] initWithType:0
                                                                                                        displayMirroringRoutes:YES];
    MPAVRoutingController *tableRouteController = [tableViewController routingController];
    [tableRouteController fetchAvailableRoutesWithCompletionHandler:^(NSArray *routes) {
        for (MPAVRoute *route in routes) {
            MPAVRoute *displayRoute = [route wirelessDisplayRoute];
            if (displayRoute) {
                [tableRouteController pickRoute:displayRoute];
                [timer invalidate];
            }
        }
    }];
}

- (void)disableMirroring:(NSTimer *)timer {
    MPAudioVideoRoutingTableViewController *tableViewController = [[MPAudioVideoRoutingTableViewController alloc] initWithType:0
                                                                                                        displayMirroringRoutes:YES];
    MPAVRoutingController *tableRouteController = [tableViewController routingController];
    [tableRouteController fetchAvailableRoutesWithCompletionHandler:^(NSArray *routes) {
        [tableRouteController pickHandsetRoute];
        [timer invalidate];
    }];
}

@end