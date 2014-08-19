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
                                                           beginColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f8f1)
                                                             endColor:MY_UICOLOR_FROM_HEX_RGB(0xf4efea)
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
    
    [_lblWelcome setTextColor:MY_UICOLOR_FROM_HEX_RGB(0xff6a56)];
    [_lblWelcome setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Medium" size:30.0f]];
    
    [_lblCity setTextColor:MY_UICOLOR_FROM_HEX_RGB(0xff6a56)];
    [_lblCity setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Regular" size:20.0f]];
    
    if(MY_IS_SCREENHEIGHT_568)
    {
        _usernameView = [[UIView alloc] initWithFrame:CGRectMake(35, 320, 250, 50)];
        _passwordView = [[UIView alloc] initWithFrame:CGRectMake(35, 380, 250, 50)];
        
        //+120
        _btnLogin.frame = CGRectMake(35, 445, 180, 45);
        _btnFacebook.frame = CGRectMake(233, 445, 52, 45);
        
        //img + lbels
        _imgLogo.frame = CGRectMake(101, 70, 119, 136);
        _lblWelcome.frame = CGRectMake(0, 230, 320, 40);
        _lblCity.frame = CGRectMake(0, 270, 320, 33);
        
        _btnRegister.frame = CGRectMake(66, 520, 189, 30);
    }
    else
    {
        _usernameView = [[UIView alloc] initWithFrame:CGRectMake(35, 240, 250, 50)];
        _passwordView = [[UIView alloc] initWithFrame:CGRectMake(35, 300, 250, 50)];
        
        _btnLogin.frame = CGRectMake(35, 365, 180, 45);
        _btnFacebook.frame = CGRectMake(233, 365, 52, 45);
    }
    
    [_usernameView setBackgroundColor:[UIColor whiteColor]];
    [_passwordView  setBackgroundColor:[UIColor whiteColor]];
    
    
    //rounded corners
    UIBezierPath *maskPathUsername = [UIBezierPath bezierPathWithRoundedRect:_usernameView.bounds
                                                   byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                         cornerRadii:CGSizeMake(5.0f, 5.0f)];

    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _usernameView.bounds;
    maskLayer.path = maskPathUsername.CGPath;
    //[maskLayer setStrokeColor:[UIColor blackColor].CGColor];
    //[maskLayer setLineWidth:2.0f];
    _usernameView.layer.mask = maskLayer;

    UIBezierPath *maskPathPassword = [UIBezierPath bezierPathWithRoundedRect:_passwordView.bounds
                                                           byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                                 cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayerPassword = [CAShapeLayer layer];
    maskLayerPassword.frame = _passwordView.bounds;
    maskLayerPassword.path = maskPathPassword.CGPath;
    _passwordView.layer.mask = maskLayerPassword;


    if(MY_IS_IOS6)
        usernameTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 18, _usernameView.frame.size.width, _usernameView.frame.size.height)];
    else
        usernameTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 3, _usernameView.frame.size.width, _usernameView.frame.size.height)];
    usernameTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    usernameTf.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [usernameTf setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f]];
    usernameTf.delegate = self;
    [usernameTf setKeyboardType:UIKeyboardTypeEmailAddress];
    usernameTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    usernameTf.textAlignment = NSTextAlignmentCenter;
    [_usernameView addSubview:usernameTf];
    
    if(MY_IS_IOS6)
        passwordTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 18, _passwordView.frame.size.width, _passwordView.frame.size.height)];
    else
        passwordTf = [[UITextField alloc]initWithFrame:CGRectMake(0, 3, _passwordView.frame.size.width, _passwordView.frame.size.height)];
    passwordTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    passwordTf.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [passwordTf setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f]];
    passwordTf.delegate = self;
    [passwordTf setSecureTextEntry:YES];
    passwordTf.textAlignment = NSTextAlignmentCenter;
    [_passwordView addSubview:passwordTf];
    
    [_btnLogin initWithType:ST_BUTTON_TYPE_ORANGE string:@"LOGIN"];
    
    [_btnFacebook initWithType:ST_BUTTON_TYPE_FB string:@""];
    
    _btnRegister.titleLabel.font = [UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:18.0f];
    
    [_btnLogin addTarget:self
                 action:@selector(doLogin)
       forControlEvents:UIControlEventTouchUpInside];
    
    [_btnFacebook addTarget:self
                  action:@selector(fbClicked)
        forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:_usernameView];
    [_scrollView addSubview:_passwordView];
    [_scrollView addSubview:_btnLogin];
    
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
    
    [TSMessage showNotificationInViewController:self title:@"Error" subtitle:message type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
}


#pragma mark - Miscellaneous

-(void) dismissKeyboard
{
    [usernameTf resignFirstResponder];
    [passwordTf resignFirstResponder];
    
    [_scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

#pragma mark - Login function

-(void)doLogin
{
    if([[usernameTf text] length] == 0)
    {
        NSLog(@"username empty");
        [usernameTf becomeFirstResponder];
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Missing username!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        return;
    }
    
    if([[passwordTf text] length] == 0)
    {
        NSLog(@"password empty");
        [passwordTf becomeFirstResponder];
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Missing password!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        return;
    }
    
    if(![STUtilities isMailAddressValid:[usernameTf text]])
    {
        NSLog(@"email address invalid");
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Email address invalid!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
    
        [usernameTf becomeFirstResponder];

        return;
    }
    
    //test: @"adam@hundaskra.is", @"1234"
    [[STNetworkManager managerWithDelegate:self] requestAuthenticate:[usernameTf text] password:[passwordTf text]];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    
    if (textField == usernameTf) {
        if(MY_IS_SCREENHEIGHT_568)
            [_scrollView setContentOffset:CGPointMake(0.0, 150.0) animated:YES];
        else
            [_scrollView setContentOffset:CGPointMake(0.0, 150.0) animated:YES];
    } else if (textField == passwordTf) {
        if(MY_IS_SCREENHEIGHT_568)
            [_scrollView setContentOffset:CGPointMake(0.0, 150.0) animated:YES];
        else
            [_scrollView setContentOffset:CGPointMake(0.0, 150.0) animated:YES];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == usernameTf)
    {
        [passwordTf becomeFirstResponder];
    }
    else if(textField == passwordTf)
    {
        //login
        NSLog(@"do login");
        [self doLogin];
    }
    
    return YES;
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
                                            @"secret" : APP_SECRET
                                        
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

- (IBAction)registerClicked:(id)sender {
        [MY_APP_DELEGATE switchToScreen:SCREEN_REGISTER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
