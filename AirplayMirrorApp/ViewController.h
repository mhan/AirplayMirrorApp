//
//  ViewController.h
//  AirplayMirrorApp
//
//  Created by michaelhan on 2014-12-01.
//  Copyright (c) 2014 Michael Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate>

//@property (nonatomic, strong) MPAudioVideoRoutingActionSheet *routingAction

- (IBAction)showPopover:(id)sender;
- (IBAction)handleEnableMirroring:(id)sender;
- (IBAction)handleDisableMirroring:(id)sender;

@end

