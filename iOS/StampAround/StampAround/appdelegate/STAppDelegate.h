//
//  STAppDelegate.h
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STStartViewController.h"
#import "STLoginViewController.h"
#import "STLoginViewController.h"
#import "STRegisterViewController.h"
#import "STCategoriesViewController.h"
#import "STStampCardViewController.h"
#import "STSessionManager.h"
#import <FacebookSDK.h>

extern NSString *const FBSessionStateChangedNotification;

@interface STAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong) STStartViewController *startViewController;
@property(nonatomic, strong) STLoginViewController *loginViewController;
@property(nonatomic, strong) STRegisterViewController *registerViewController;
@property(nonatomic, strong) STCategoriesViewController *categoriesViewController;
@property(nonatomic, strong) STStampCardViewController *stampCardViewController;
@property(nonatomic, strong) UINavigationController *navigationController;

@property (strong, nonatomic) NSString *loggedInUserID;
@property (strong, nonatomic) FBSession *loggedInSession;

- (void)switchToScreen:(int)screen;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void)closeSession;
- (void)logout;
- (void)openFbSession;

@end

//start screens
#define SCREEN_START            0
#define SCREEN_LOGIN            1
#define SCREEN_REGISTER         2

#define SCREEN_CATEGORIES       3
#define SCREEN_STAMP_CARD       4


