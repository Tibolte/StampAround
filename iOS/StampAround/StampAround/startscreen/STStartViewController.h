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

@end

#define REFRESH_INTERVAL        0.15 
