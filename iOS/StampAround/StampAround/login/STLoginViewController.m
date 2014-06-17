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
    
    //[[STNetworkManager managerWithDelegate:self] requestAuthenticate:@"adam@hundaskra.is" password:@"1234"];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setViewItems
{
    _usernameView = [[UIView alloc] initWithFrame:CGRectMake(35, 245, 250, 50)];
    _passwordView = [[UIView alloc] initWithFrame:CGRectMake(35, 300, 250, 50)];
    
    [_usernameView setBackgroundColor:[UIColor whiteColor]];
    [_passwordView  setBackgroundColor:[UIColor whiteColor]];
    
    usernameTf = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 150, 30)];
    usernameTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    usernameTf.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_usernameView addSubview:usernameTf];
    
    passwordTf = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 150, 30)];
    passwordTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    passwordTf.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_passwordView addSubview:passwordTf];
    
    _sendButtonView = [[UIView alloc] initWithFrame:CGRectMake(35, 370, 250, 50)];
    _sendButtonView.backgroundColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:0.7];
    
    //BUTTON
    UIButton * sendButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _sendButtonView.frame.size.width, _sendButtonView.frame.size.height)];
    [sendButton setTitle:@"LOGIN" forState:UIControlStateNormal];
    [sendButton setTitleColor:MY_UICOLOR_FROM_HEX_RGB(0xeef3ed) forState:UIControlStateNormal];
    [sendButton setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0x858688)];
    
    [_sendButtonView addSubview:sendButton];
    
    [sendButton addTarget:self
                 action:@selector(doLogin)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_usernameView];
    [self.view addSubview:_passwordView];
    [self.view addSubview:_sendButtonView];    
    
    //GESTURE - Dismiss the keyboard when tapped on the controller's view
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fbClicked)];
    [_fbView addGestureRecognizer:singleTap];
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
    if (FBSession.activeSession.isOpen) {
        [MY_APP_DELEGATE closeSession];
    } else {
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [MY_APP_DELEGATE openSessionWithAllowLoginUI:YES];
    }
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
        [_lblFb setText:@"Connect with Facebook"];
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
