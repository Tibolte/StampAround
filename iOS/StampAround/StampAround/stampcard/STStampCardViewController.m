//
//  STStampCardViewController.m
//  StampAround
//
//  Created by Thibault Guégan on 03/07/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STStampCardViewController.h"

@interface STStampCardViewController ()

@end

@implementation STStampCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_lblStampInstructions setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Regular" size:14.0f]];
    _lblStampInstructions.textColor = MY_UICOLOR_FROM_HEX_RGB(0xff6a56);
    _lblStampInstructions.text = @"You get the 10'th cup of coffee for free. Offer valid on all coffee drinks on the menu";
    
    [_lblName setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Bold" size:14.0f]];
    [_lblAddress setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Regular" size:14.0f]];
    [_lblPhone setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Regular" size:14.0f]];
    [_lblWebsite setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Regular" size:14.0f]];
    _lblName.textColor = MY_UICOLOR_FROM_HEX_RGB(0x02272e);
    _lblAddress.textColor = MY_UICOLOR_FROM_HEX_RGB(0x02272e);
    _lblPhone.textColor = MY_UICOLOR_FROM_HEX_RGB(0x02272e);
    _lblWebsite.textColor = MY_UICOLOR_FROM_HEX_RGB(0x02272e);
    
    //test
    [_lblName setText:@"Te og kaffi"];
    [_lblAddress setText:@"laugavegur 100 101 Reykjavik"];
    [_lblPhone setText:@"+354 5563959"];
    [_lblWebsite setText:@"www.teogkaffi.is"];

    if(!MY_IS_SCREENHEIGHT_568)
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 580);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
