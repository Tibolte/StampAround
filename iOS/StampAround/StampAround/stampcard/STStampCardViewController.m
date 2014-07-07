//
//  STStampCardViewController.m
//  StampAround
//
//  Created by Thibault Guégan on 03/07/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STStampCardViewController.h"

@interface STStampCardViewController ()

@property(nonatomic, strong) NSMutableArray *imgArray;

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
    
    _bottomBar.delegate = self;

    if(!MY_IS_SCREENHEIGHT_568)
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 580);
    
    _imgArray = [[NSMutableArray alloc] init];
    [_imgArray addObject:_imgStamp1];
    [_imgArray addObject:_imgStamp2];
    [_imgArray addObject:_imgStamp3];
    [_imgArray addObject:_imgStamp4];
    [_imgArray addObject:_imgStamp5];
    [_imgArray addObject:_imgStamp6];
    [_imgArray addObject:_imgStamp7];
    [_imgArray addObject:_imgStamp8];
    [_imgArray addObject:_imgStamp9];

}

#pragma mark - ST Bottom bar delegate

- (void)mapClicked
{
    
}

- (void)stampClicked
{
    // create the scanning view controller and a navigation controller in which to present it:
    CDZQRScanningViewController *scanningVC = [CDZQRScanningViewController new];
    UINavigationController *scanningNavVC = [[UINavigationController alloc] initWithRootViewController:scanningVC];
    
    // configure the scanning view controller:
    scanningVC.resultBlock = ^(NSString *result) {
        //field.text = result;
        NSLog(@"Scanning result: %@", result);
        [self updateStamps];
        [scanningNavVC dismissViewControllerAnimated:YES completion:nil];
    };
    scanningVC.cancelBlock = ^() {
        [scanningNavVC dismissViewControllerAnimated:YES completion:nil];
    };
    scanningVC.errorBlock = ^(NSError *error) {
        // todo: show a UIAlertView orNSLog the error
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Failed to scan QR Code!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        [scanningNavVC dismissViewControllerAnimated:YES completion:nil];
    };
    
    // present the view controller full-screen on iPhone; in a form sheet on iPad:
    scanningNavVC.modalPresentationStyle = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
    [self presentViewController:scanningNavVC animated:YES completion:nil];
}

- (void)myCardsClicked
{
    
}

#pragma mark - Update stamps

- (void)updateStamps
{
    int i = 0;
    for(UIImageView *img in _imgArray)
    {
        i++;

        if([img isHidden])
        {
            [img setHidden:FALSE];
            break;
        }
    }
    
    if(i==9)
    {
        for(UIImageView *img in _imgArray)
        {
            [img setHidden:TRUE];
        }
        
        [TSMessage showNotificationInViewController:self title:@"Success" subtitle:@"You have the 10th coffee for free!" type:TSMessageNotificationTypeSuccess duration:4.0 canBeDismissedByUser:YES];
        
        i = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
