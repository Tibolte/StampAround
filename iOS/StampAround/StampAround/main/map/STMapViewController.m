//
//  STMapViewController.m
//  StampAround
//
//  Created by Thibault on 11/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STMapViewController.h"

@interface STMapViewController ()

@end

@implementation STMapViewController

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
    // Do any additional setup after loading the view from its nib.
    
    // back gesture
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownGesture:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [_fakeView addGestureRecognizer:swipeGestureRecognizer];
    [swipeGestureRecognizer setDelegate:self];
}

#pragma mark - User Actions

-(void)swipeDownGesture:(UIGestureRecognizer*)gesture{
    
    //[MY_APP_DELEGATE switchToScreen:SCREEN_CATEGORIES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
