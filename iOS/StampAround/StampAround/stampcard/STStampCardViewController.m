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
    
    // back gesture
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBackGesture:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeGestureRecognizer];
    [swipeGestureRecognizer setDelegate:self];
    
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

        if([img alpha] == 0)
        {
            [UIView animateWithDuration:0.1 animations:^{img.alpha = 1.0;}];
            
            img.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
            
            CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            bounceAnimation.values = [NSArray arrayWithObjects:
                                      [NSNumber numberWithFloat:0.5],
                                      [NSNumber numberWithFloat:1.1],
                                      [NSNumber numberWithFloat:0.8],
                                      [NSNumber numberWithFloat:1.0], nil];
            bounceAnimation.duration = 0.3;
            bounceAnimation.removedOnCompletion = NO;
            [img.layer addAnimation:bounceAnimation forKey:@"bounce"];
            
            img.layer.transform = CATransform3DIdentity;
            
            //vibrate
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

            break;
        }
    }
    
    if(i==9)
    {
        for(UIImageView *img in _imgArray)
        {
            //[self setHiddenAnimated:NO view:img];
            [img setAlpha:0];
        }
        
        [TSMessage showNotificationInViewController:self title:@"Success" subtitle:@"You have the 10th coffee for free!" type:TSMessageNotificationTypeSuccess duration:4.0 canBeDismissedByUser:YES];
        
        i = 0;
    }
}

#pragma mark - User Actions

-(void)swipeBackGesture:(UIGestureRecognizer*)gesture{
    
    //[MY_APP_DELEGATE switchToScreen:SCREEN_CATEGORIES];
    [self.navigationController popViewControllerAnimated:YES]; 
}

#pragma mark - STButton animation

+ (CAKeyframeAnimation*)dockBounceAnimationWithViewHeight:(CGFloat)viewHeight
{
    NSUInteger const kNumFactors    = 22;
    CGFloat const kFactorsPerSec    = 30.0f;
    CGFloat const kFactorsMaxValue  = 128.0f;
    CGFloat factors[kNumFactors]    = {0,  60, 83, 100, 114, 124, 128, 128, 124, 114, 100, 83, 60, 32, 0, 0, 18, 28, 32, 28, 18, 0};
    
    NSMutableArray* transforms = [NSMutableArray array];
    
    for(NSUInteger i = 0; i < kNumFactors; i++)
    {
        CGFloat positionOffset  = factors[i] / kFactorsMaxValue * viewHeight;
        CATransform3D transform = CATransform3DMakeTranslation(0.0f, -positionOffset, 0.0f);
        
        [transforms addObject:[NSValue valueWithCATransform3D:transform]];
    }
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.repeatCount           = 1;
    animation.duration              = kNumFactors * 1.0f/kFactorsPerSec;
    animation.fillMode              = kCAFillModeForwards;
    animation.values                = transforms;
    animation.removedOnCompletion   = YES; // final stage is equal to starting stage
    animation.autoreverses          = NO;
    
    return animation;
}

- (void)bounce:(float)bounceFactor image:(UIImageView *)img
{
    CGFloat midHeight = img.frame.size.height * bounceFactor;
    CAKeyframeAnimation* animation = [[self class] dockBounceAnimationWithViewHeight:midHeight];
    [img.layer addAnimation:animation forKey:@"bouncing"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
