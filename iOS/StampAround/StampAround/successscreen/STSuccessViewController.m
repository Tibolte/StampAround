//
//  STSuccessViewController.m
//  StampAround
//
//  Created by Thibault on 14/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STSuccessViewController.h"

@interface STSuccessViewController ()

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation STSuccessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xff6a56)];

    
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    fullRotation.duration = 6;
    fullRotation.repeatCount = 1e100f;
    [_imgBeams.layer addAnimation:fullRotation forKey:@"360"];
    
    [_lblSuccess setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Medium" size:kButtonFontSize]];

    _lblSuccess.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:1.0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0], nil];
    bounceAnimation.duration = 1.0;
    bounceAnimation.removedOnCompletion = NO;
    [_lblSuccess.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
    _lblSuccess.layer.transform = CATransform3DIdentity;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                              target:self
                                            selector:@selector(dismiss)
                                            userInfo:nil
                                             repeats:NO];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
