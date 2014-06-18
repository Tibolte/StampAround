//
//  STLoginViewController.m
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STLoginViewController.h"

@interface STLoginViewController ()
{
    UITextField * usernameTf;
    UITextField * passwordTf;
}
@end

@implementation STLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init GUI
    
    UIImageView *gradientBackground = [STUtilities imageViewWithFrame:[[self view] frame]
                                                           beginColor:MY_UICOLOR_FROM_HEX_RGB(0xdbe9e9)
                                                             endColor:MY_UICOLOR_FROM_HEX_RGB(0xfffde5)
                                                                 type:STUTILITIES_TYPE_TOP_TO_BOTTOM];
    [[self view] addSubview:gradientBackground];
    [[self view] sendSubviewToBack:gradientBackground];
    
    [self setViewItems];
    
    // Register for notifications on FB session state changes
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];

    // Check the session for a cached token to show the proper authenticated
    // UI. However, since this is not user intitiated, do not show the login UX.
    [MY_APP_DELEGATE openSessionWithAllowLoginUI:NO];
    
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setViewItems
{
    
    [_lblWelcome setTextColor:MY_UICOLOR_FROM_HEX_RGB(0xec8d71)];
    [_lblWelcome setFont:[UIFont fontWithName:@"DINEngschriftStd" size:40.0f]];
    
    _usernameView = [[UIView alloc] initWithFrame:CGRectMake(35, 200, 250, 50)];
    _passwordView = [[UIView alloc] initWithFrame:CGRectMake(35, 260, 250, 50)];
    
    [_usernameView setBackgroundColor:[UIColor whiteColor]];
    [_passwordView  setBackgroundColor:[UIColor whiteColor]];
    
    //rounded corners
    UIBezierPath *maskPathUsername = [UIBezierPath bezierPathWithRoundedRect:_usernameView.bounds
                                                   byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                         cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _usernameView.bounds;
    maskLayer.path = maskPathUsername.CGPath;
    _usernameView.layer.mask = maskLayer;

    UIBezierPath *maskPathPassword = [UIBezierPath bezierPathWithRoundedRect:_passwordView.bounds
                                                           byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                                 cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayerPassword = [CAShapeLayer layer];
    maskLayerPassword.frame = _passwordView.bounds;
    maskLayerPassword.path = maskPathPassword.CGPath;
    _passwordView.layer.mask = maskLayerPassword;


    usernameTf = [[UITextField alloc]initWithFrame:CGRectMake(90, 13, 150, 30)];
    usernameTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    usernameTf.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [usernameTf setFont:[UIFont fontWithName:@"DINEngschriftStd" size:20.0f]];
    [_usernameView addSubview:usernameTf];
    
    passwordTf = [[UITextField alloc]initWithFrame:CGRectMake(90, 13, 150, 30)];
    passwordTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    passwordTf.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [passwordTf setFont:[UIFont fontWithName:@"DINEngschriftStd" size:20.0f]];
    [_passwordView addSubview:passwordTf];
    
    [_btnLogin initWithType:ST_BUTTON_TYPE_ORANGE string:@"LOGIN"];
    
    [_btnFacebook initWithType:ST_BUTTON_TYPE_FB string:@""];
    
    [_btnLogin addTarget:self
                 action:@selector(doLogin)
       forControlEvents:UIControlEventTouchUpInside];
    
    [_btnFacebook addTarget:self
                  action:@selector(fbClicked)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_usernameView];
    [self.view addSubview:_passwordView];
    [self.view addSubview:_btnLogin];
    
    //GESTURE - Dismiss the keyboard when tapped on the controller's view
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
}

#pragma mark - Network Delegate


-(void)downloadResponse:(id)responseObject message:(NSString *)message{
    
    NSLog(@"%@", responseObject);
    NSLog(@"%@", message);
    
    [[STSessionManager manager] saveCredentialsWithUsername:[responseObject objectForKey:@"email"] token:[responseObject objectForKey:@"accessToken"] secret:[responseObject objectForKey:@"accessSecret"]];
    
    [MY_APP_DELEGATE switchToScreen:SCREEN_CATEGORIES];
}

-(void)downloadFailureCode:(int)errCode message:(NSString *)message{
    
    
    //TODO: delete token??
    
    NSLog(@"error %@", message);
}


#pragma mark - Miscellaneous

-(void) dismissKeyboard
{
    [usernameTf resignFirstResponder];
    [passwordTf resignFirstResponder];
}

#pragma mark - Miscellaneous

-(void)doLogin
{
    [[STNetworkManager managerWithDelegate:self] requestAuthenticate:@"adam@hundaskra.is" password:@"1234"];
}

#pragma mark - Facebook

- (void)fbClicked
{
    NSLog(@"%@", @"fb tapped");
    
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    
    // If the user is authenticated, log out when the button is clicked.
    // If the user is not authenticated, log in when the button is clicked.
    /*if (FBSession.activeSession.isOpen) {
        [MY_APP_DELEGATE closeSession];
    } else {
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [MY_APP_DELEGATE openSessionWithAllowLoginUI:YES];
    }*/
}

/*
 * Configure the logged in versus logged out UI
 */
- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSString *firstName = user.first_name;
                 NSString *lastName = user.last_name;
                 NSString *facebookId = user.id;
                 NSString *email = [user objectForKey:@"email"];
                 NSString *imageUrl = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
                 
                 NSLog(@"first name: %@", firstName);
                 NSLog(@"lastName: %@", lastName);
                 NSLog(@"facebookId: %@", facebookId);
                 NSLog(@"email: %@", email);
                 NSLog(@"imageUrl: %@", imageUrl);
                 
                 NSLog(@"access token: %@", FBSession.activeSession.accessTokenData.accessToken);
                 
                 NSDictionary *postDict = @{@"facebookId": facebookId,
                                            @"facebookToken": FBSession.activeSession.accessTokenData.accessToken,
                                            @"firstName": firstName,
                                            @"lastName" : lastName,
                                            @"email" : email,
                                            @"imageUrl" : imageUrl,
                                            @"secret" : @"3744a7b11dd1183658c2381c30617fcb"
                                        
                                          };
                 
                 //register then
                 [[STNetworkManager managerWithDelegate:self] requestRegisterFacebook:postDict];

             }
         }];
        
        [MY_APP_DELEGATE switchToScreen:SCREEN_CATEGORIES];
    } else {
        //[_lblFb setText:@"Connect with Facebook"];
    }
}

- (IBAction)btnRegisterClicked:(id)sender {
        [MY_APP_DELEGATE switchToScreen:SCREEN_REGISTER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
