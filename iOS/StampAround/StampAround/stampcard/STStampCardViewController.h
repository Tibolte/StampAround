//
//  STStampCardViewController.h
//  StampAround
//
//  Created by Thibault Guégan on 03/07/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBottomBar.h"
#import <CDZQRScanningViewController.h>
#import <AudioToolbox/AudioServices.h>
#import "STStore.h"
#import "STMyCardsViewController.h"
#import "STMapViewController.h"

@interface STStampCardViewController : UIViewController<STBottomBarProtocol,UIGestureRecognizerDelegate>

@property(nonatomic,strong) STStore *store;

@property (weak, nonatomic) IBOutlet STBottomBar *bottomBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblStampInstructions;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblWebsite;

//stamps
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp1;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp2;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp3;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp4;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp5;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp6;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp7;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp8;
@property (weak, nonatomic) IBOutlet UIImageView *imgStamp9;

@end
