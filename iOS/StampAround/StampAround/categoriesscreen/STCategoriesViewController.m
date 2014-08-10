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
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(screenFrame.size.width/2.0f, 0, 1.0f, screenFrame.size.height)];
    [verticalLine setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0x002f3b)];
    [self.view addSubview:verticalLine];
    
    UIView *horizontalLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenFrame.size.height-_bottomBar.frame.size.height)/3.0f, screenFrame.size.width, 1.0f)];
    [horizontalLine1 setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0x002f3b)];
    [self.view addSubview:horizontalLine1];
    
    UIView *horizontalLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, (screenFrame.size.height-_bottomBar.frame.size.height)*(2.0f/3.0f), screenFrame.size.width, 1.0f)];
    [horizontalLine2 setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0x002f3b)];
    [self.view addSubview:horizontalLine2];
    
    CGRect btnGridFrame;
    if(MY_IS_SCREENHEIGHT_568)
    {
        btnGridFrame = CGRectMake(0, 0, 104, 130);
    }
    else
    {
        btnGridFrame = CGRectMake(0, 0, 80, 100);
    }
    
    STButton *buttonRestaurant = [[STButton alloc] initWithFrame:btnGridFrame];
    [buttonRestaurant initWithType:ST_BUTTON_TYPE_GRID string:@"restaurants"];
    buttonRestaurant.center = CGPointMake(screenFrame.size.width/4.0f, (screenFrame.size.height-_bottomBar.frame.size.height)/6.0f);
    [self.view addSubview:buttonRestaurant];
    
    [buttonRestaurant addTarget:self
                  action:@selector(showRestaurants)
        forControlEvents:UIControlEventTouchUpInside];
    
    STButton *buttonCafe = [[STButton alloc] initWithFrame:btnGridFrame];
    [buttonCafe initWithType:ST_BUTTON_TYPE_GRID string:@"café"];
    buttonCafe.center = CGPointMake(screenFrame.size.width*(3.0f/4.0f), (screenFrame.size.height-_bottomBar.frame.size.height)/6.0f);
    [self.view addSubview:buttonCafe];
    
    [buttonCafe addTarget:self
                         action:@selector(showCafe)
               forControlEvents:UIControlEventTouchUpInside];

    
    STButton *buttonDrinks = [[STButton alloc] initWithFrame:btnGridFrame];
    [buttonDrinks initWithType:ST_BUTTON_TYPE_GRID string:@"drinks"];
    buttonDrinks.center = CGPointMake(screenFrame.size.width/4.0f, (screenFrame.size.height-_bottomBar.frame.size.height)*(3.0f/6.0f));
    [self.view addSubview:buttonDrinks];
    
    [buttonDrinks addTarget:self
                   action:@selector(showDrinks)
         forControlEvents:UIControlEventTouchUpInside];
    
    STButton *buttonEntertainment = [[STButton alloc] initWithFrame:btnGridFrame];
    [buttonEntertainment initWithType:ST_BUTTON_TYPE_GRID string:@"entertainment"];
    buttonEntertainment.center = CGPointMake(screenFrame.size.width/4.0f, (screenFrame.size.height-_bottomBar.frame.size.height)*(5.0f/6.0f));
    [self.view addSubview:buttonEntertainment];
    
    [buttonEntertainment addTarget:self
                     action:@selector(showEntertainment)
           forControlEvents:UIControlEventTouchUpInside];
    
    STButton *buttonGroom = [[STButton alloc] initWithFrame:btnGridFrame];
    [buttonGroom initWithType:ST_BUTTON_TYPE_GRID string:@"groom"];
    buttonGroom.center = CGPointMake(screenFrame.size.width*(3.0f/4.0f), (screenFrame.size.height-_bottomBar.frame.size.height)*(3.0f/6.0f));
    [self.view addSubview:buttonGroom];
    
    [buttonGroom addTarget:self
                            action:@selector(showGroom)
                  forControlEvents:UIControlEventTouchUpInside];
    
    STButton *buttonOffers = [[STButton alloc] initWithFrame:btnGridFrame];
    [buttonOffers initWithType:ST_BUTTON_TYPE_GRID string:@"offers"];
    buttonOffers.center = CGPointMake(screenFrame.size.width*(3.0f/4.0f), (screenFrame.size.height-_bottomBar.frame.size.height)*(5.0f/6.0f));
    [self.view addSubview:buttonOffers];
    
    [buttonOffers addTarget:self
                    action:@selector(showOffers)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:_bottomBar];
    
    _bottomBar.delegate = self;
    
    
    [[STNetworkManager managerWithDelegate:self] requestCategories];
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
    STMyCardsViewController *controller = [[STMyCardsViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - ST Buttons click actions

- (void)showRestaurants
{
    [self startStoresController:1];
}

- (void)showCafe
{
    [self startStoresController:3];
}

- (void)showDrinks
{
    [self startStoresController:2];
}

- (void)showGroom
{
    [self startStoresController:5];
}

- (void)showEntertainment
{
    [self startStoresController:4];
}

- (void)showOffers
{
    [self startStoresController:6];
}

-(void)startStoresController:(int)category
{
    STStoresViewController *controller = [[STStoresViewController alloc] init];
    controller.categoryId = category;
    [self.navigationController pushViewController:controller animated:YES];
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
