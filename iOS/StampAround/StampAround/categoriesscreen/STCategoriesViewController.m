//
//  STCategoriesViewController.m
//  StampAround
//
//  Created by Thibault Guégan on 16/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STCategoriesViewController.h"

@interface STCategoriesViewController ()

@end

@implementation STCategoriesViewController

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
    
    [self.view setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f6f0)];
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    //draw line
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(screenFrame.size.width/2.0f, 0, 1.0f, screenFrame.size.height - _bottomBar.frame.size.height)];
    [verticalLine setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0x002f3b)];
    [self.view addSubview:verticalLine];
    
    UIView *horizontalLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenFrame.size.height-_bottomBar.frame.size.height)/3.0f, screenFrame.size.width, 1.0f)];
    [horizontalLine1 setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0x002f3b)];
    [self.view addSubview:horizontalLine1];
    
    UIView *horizontalLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenFrame.size.height-_bottomBar.frame.size.height)*(2.0f/3.0f), screenFrame.size.width, 1.0f)];
    [horizontalLine2 setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0x002f3b)];
    [self.view addSubview:horizontalLine2];
    
    [self.view bringSubviewToFront:_bottomBar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)logout:(id)sender {
    [MY_APP_DELEGATE logout];
}
@end
