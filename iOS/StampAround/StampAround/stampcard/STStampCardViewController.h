//
//  STStampCardViewController.h
//  StampAround
//
//  Created by Thibault Guégan on 03/07/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STStampCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet STBottomBar *bottomBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblStampInstructions;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblWebsite;
@end
