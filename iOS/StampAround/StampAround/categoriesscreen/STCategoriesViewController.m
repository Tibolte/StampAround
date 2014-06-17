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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    [MY_APP_DELEGATE logout];
}
@end
