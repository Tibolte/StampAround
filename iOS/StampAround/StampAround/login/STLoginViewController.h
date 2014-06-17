//
//  STLoginViewController.h
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STNetworkManager.h"
#import <FacebookSDK.h>

@interface STLoginViewController : UIViewController<STNetworkManagerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *usernameView;
@property (strong, nonatomic) UIView *passwordView;
@property (strong, nonatomic) UIView *sendButtonView;
@property (weak, nonatomic) IBOutlet UIView *fbView;
@property (weak, nonatomic) IBOutlet UILabel *lblFb;

@end
