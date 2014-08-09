//
//  STStoresViewController.m
//  StampAround
//
//  Created by Thibault on 09/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STStoresViewController.h"

@interface STStoresViewController ()

@end

@implementation STStoresViewController

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
    
    [self.view setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f6f0)];
    
    // back gesture
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBackGesture:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeGestureRecognizer];
    [swipeGestureRecognizer setDelegate:self];
    
    [[STNetworkManager managerWithDelegate:self] requestStoresByCategory:_categoryId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Actions

-(void)swipeBackGesture:(UIGestureRecognizer*)gesture{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ST Bottom bar delegate

- (void)mapClicked
{
    
}

- (void)stampClicked
{
    
}

- (void)myCardsClicked
{
    
}

#pragma mark - Network Delegate


-(void)downloadResponse:(id)responseObject message:(NSString *)message{
    
    NSLog(@"%@", responseObject);
    NSLog(@"%@", message);
    
}

-(void)downloadFailureCode:(int)errCode message:(NSString *)message{
    
    NSLog(@"error %@", message);
    
}

@end
