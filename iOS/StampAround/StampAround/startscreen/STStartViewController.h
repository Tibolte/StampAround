//
//  STStartViewController.h
//  StampAround
//
//  Created by Thibault Guégan on 14/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OJFSegmentedProgressView.h>
#import <FacebookSDK.h>
#import "STSessionManager.h"
#import "STNetworkManager.h"

@interface STStartViewController : UIViewController<STNetworkManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblStp;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@end

#define REFRESH_INTERVAL        0.15 
