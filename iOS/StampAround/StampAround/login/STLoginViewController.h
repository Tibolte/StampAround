//
//  STLoginViewController.h
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STNetworkManager.h"
#import "STUtilities.h"
#import "STButton.h"
#import <FacebookSDK.h>

@interface STLoginViewController : UIViewController<STNetworkManagerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *usernameView;
@property (strong, nonatomic) UIView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@property (weak, nonatomic) IBOutlet STButton *btnLogin;
@property (weak, nonatomic) IBOutlet STButton *btnFacebook;

@end
