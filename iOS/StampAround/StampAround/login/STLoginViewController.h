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
#import "TSMessage.h"
#import <FacebookSDK.h>

@interface STLoginViewController : UIViewController<STNetworkManagerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIView *usernameView;
@property (strong, nonatomic) UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet STButton *btnLogin;
@property (weak, nonatomic) IBOutlet STButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@end
