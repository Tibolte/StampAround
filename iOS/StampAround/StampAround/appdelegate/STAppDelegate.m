//
//  STAppDelegate.m
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STAppDelegate.h"

NSString *const FBSessionStateChangedNotification =
@"com.facebook.samples.LoginHowTo:FBSessionStateChangedNotification";

@implementation STAppDelegate

@synthesize loggedInUserID = _loggedInUserID;
@synthesize loggedInSession = _loggedInSession;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self clearControllers];
    [self switchToScreen:SCREEN_START];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)clearControllers
{
    _startViewController = nil;
    _loginViewController = nil;
    _categoriesViewController = nil;
    _registerViewController = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // We need to properly handle activation of the application with regards to SSO
    // (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // if the app is going away, we close the session object
    [FBSession.activeSession close];
}

#pragma mark - Switching screens

-(void)switchToScreen:(int)screen
{
    switch (screen) {
        case SCREEN_START:
            if(!_startViewController)
            {
                _startViewController = [[STStartViewController alloc] init];
            }
            [_window setRootViewController:_startViewController];
            break;
        case SCREEN_LOGIN:
            if(!_loginViewController)
            {
                _loginViewController = [[STLoginViewController alloc] init];
            }
            //[_loginViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            //[_startViewController presentViewController:_loginViewController animated:YES completion:nil];
            //[_window setRootViewController:_loginViewController];
            _window.rootViewController = nil;
            _navigationController = [[UINavigationController alloc] initWithRootViewController:_loginViewController];
            _window.rootViewController = _navigationController;
            
            [[_loginViewController navigationController] setNavigationBarHidden:YES];
            break;
        case SCREEN_REGISTER:
            if(!_registerViewController)
            {
                _registerViewController = [[STRegisterViewController alloc] init];
            }
            //[_window setRootViewController:_registerViewController];
            [_registerViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [_loginViewController presentViewController:_registerViewController animated:YES completion:nil];
            break;
        case SCREEN_CATEGORIES:
            if(!_categoriesViewController)
            {
                _categoriesViewController = [[STCategoriesViewController alloc] init];
            }
            
            //[[_categoriesViewController navigationController] setNavigationBarHidden:YES];
            //[_window setRootViewController:_categoriesViewController];
            
            /*if(!_navigationController)
            {
                _window.rootViewController = nil;
                _navigationController = [[UINavigationController alloc] initWithRootViewController:_categoriesViewController];
                _window.rootViewController = _navigationController;
                
            }
            else
            {
                [_navigationController pushViewController:_categoriesViewController animated:YES];
            }*/
            
            _window.rootViewController = nil;
            _navigationController = [[UINavigationController alloc] initWithRootViewController:_categoriesViewController];
            _window.rootViewController = _navigationController;
            
            [[_categoriesViewController navigationController] setNavigationBarHidden:YES];
            break;
    }
}

#pragma mark - Facebook functions

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                //NSLog(@"User session found");
                [FBRequestConnection
                 startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                   NSDictionary<FBGraphUser> *user,
                                                   NSError *error) {
                     if (!error) {
                         self.loggedInUserID = user.id;
                         self.loggedInSession = FBSession.activeSession;
                     }
                 }];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"email", nil];
    
    return [FBSession openActiveSessionWithReadPermissions:permissions
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

/*
 *
 */
- (void) closeSession {
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)openFbSession
{
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"email",
                            @"user_birthday",
                            @"user_location",
                            nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

#pragma mark - Another Actions

-(void)logout{
    
    if (FBSession.activeSession.isOpen) {
        [self closeSession];
    }
    
    [[STSessionManager manager] saveCredentialsWithUsername:@"" token:@"" secret:@""];
    [self clearControllers];
    
    [self switchToScreen:SCREEN_START];
}

@end
