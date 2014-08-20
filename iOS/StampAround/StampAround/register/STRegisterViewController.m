//
//  STRegisterViewController.m
//  StampAround
//
//  Created by Thibault Guégan on 17/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STRegisterViewController.h"

@interface STRegisterViewController ()

@end

@implementation STRegisterViewController

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
    
    UIImageView *gradientBackground = [STUtilities imageViewWithFrame:[[self view] frame]
                                                           beginColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f8f1)
                                                             endColor:MY_UICOLOR_FROM_HEX_RGB(0xf4efea)
                                                                 type:STUTILITIES_TYPE_TOP_TO_BOTTOM];
    [[self view] addSubview:gradientBackground];
    [[self view] sendSubviewToBack:gradientBackground];
    
    [self setViewItems];
}

- (void)setViewItems
{
    //rounded corners
    UIBezierPath *maskPathUsername = [UIBezierPath bezierPathWithRoundedRect:_nameView.bounds
                                                           byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                                 cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _nameView.bounds;
    maskLayer.path = maskPathUsername.CGPath;
    _nameView.layer.mask = maskLayer;
    
    UIBezierPath *maskPathEmail = [UIBezierPath bezierPathWithRoundedRect:_mailView.bounds
                                                           byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                                 cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayerEmail = [CAShapeLayer layer];
    maskLayerEmail.frame = _mailView.bounds;
    maskLayerEmail.path = maskPathEmail.CGPath;
    _mailView.layer.mask = maskLayerEmail;
    
    UIBezierPath *maskPathConfirmEmail = [UIBezierPath bezierPathWithRoundedRect:_confirmMailView.bounds
                                                        byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                              cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayerConfirmEmail = [CAShapeLayer layer];
    maskLayerConfirmEmail.frame = _confirmMailView.bounds;
    maskLayerConfirmEmail.path = maskPathConfirmEmail.CGPath;
    _confirmMailView.layer.mask = maskLayerConfirmEmail;
    
    UIBezierPath *maskPathPass = [UIBezierPath bezierPathWithRoundedRect:_passView.bounds
                                                        byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                              cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayerPass = [CAShapeLayer layer];
    maskLayerPass.frame = _passView.bounds;
    maskLayerPass.path = maskPathPass.CGPath;
    _passView.layer.mask = maskLayerPass;
    
    
    UIBezierPath *maskPathConfirmPass = [UIBezierPath bezierPathWithRoundedRect:_confirmPassView.bounds
                                                               byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                                     cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayerConfirmPass = [CAShapeLayer layer];
    maskLayerConfirmPass.frame = _confirmPassView.bounds;
    maskLayerConfirmPass.path = maskPathConfirmPass.CGPath;
    _confirmPassView.layer.mask = maskLayerConfirmPass;
    
    _nameEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _nameEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_nameEdit setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f]];
    _nameEdit.delegate = self;
    
    _mailEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _mailEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_mailEdit setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f]];
    _mailEdit.delegate = self;
    
    _confirmMailEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm e-mail" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _confirmMailEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_confirmMailEdit setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f]];
    _confirmMailEdit.delegate = self;
    
    _passEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _passEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_passEdit setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f]];
    [_passEdit setSecureTextEntry:YES];
    _passEdit.delegate = self;
    
    _confirmPassEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _confirmPassEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_confirmPassEdit setFont:[UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f]];
    [_confirmPassEdit setSecureTextEntry:YES];
    _confirmPassEdit.delegate = self;
    
    [_btnRegister initWithType:ST_BUTTON_TYPE_ORANGE string:@"REGISTER"];
    [_btnRegister addTarget:self
                  action:@selector(doRegister)
        forControlEvents:UIControlEventTouchUpInside];
    
    _btnCancel.titleLabel.font = [UIFont fontWithName:@"DINNextRoundedLTPro-Light" size:20.0f];
    
    //GESTURE - Dismiss the keyboard when tapped on the controller's view
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    
    if (textField == _confirmPassEdit) {
        if(MY_IS_SCREENHEIGHT_568)
            [_scrollView setContentOffset:CGPointMake(0.0, 80.0) animated:YES];
        else
            [_scrollView setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
    }
    else if(textField == _passEdit)
    {
        if(MY_IS_SCREENHEIGHT_568)
            [_scrollView setContentOffset:CGPointMake(0.0, 80.0) animated:YES];
        else
            [_scrollView setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
    }
    else if(textField == _confirmMailEdit)
    {
        if(MY_IS_SCREENHEIGHT_568)
            [_scrollView setContentOffset:CGPointMake(0.0, 80.0) animated:YES];
        else
            [_scrollView setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
    }
    else if (textField == _mailEdit) {
        if(MY_IS_SCREENHEIGHT_568)
            [_scrollView setContentOffset:CGPointMake(0.0, 80.0) animated:YES];
        else
             [_scrollView setContentOffset:CGPointMake(0.0, 100.0) animated:YES];
    }
    else if (textField == _nameEdit) {
        if(MY_IS_SCREENHEIGHT_568)
            [_scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
        else
            [_scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == _nameEdit)
    {
        [_mailEdit becomeFirstResponder];
    }
    else if(textField == _mailEdit)
    {
        [_confirmMailEdit becomeFirstResponder];
    }
    else if(textField == _confirmMailEdit)
    {
        [_passEdit becomeFirstResponder];
    }
    else if(textField == _passEdit)
    {
        [_confirmPassEdit becomeFirstResponder];
    }
    else if(textField == _confirmPassEdit)
    {
        //TODO: register
        
        NSLog(@"do register");
        [self doRegister];
    }
    
    return YES;
}

#pragma mark - Miscellaneous

-(void) dismissKeyboard
{
    [_nameEdit resignFirstResponder];
    [_mailEdit resignFirstResponder];
    [_confirmMailEdit resignFirstResponder];
    [_passEdit resignFirstResponder];
    [_confirmPassEdit resignFirstResponder];

    [_scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

#pragma mark - Register function

-(void)doRegister
{
    [self dismissKeyboard];

    if([[_nameEdit text] length] == 0)
    {
        NSLog(@"username empty");
        [_nameEdit becomeFirstResponder];
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Missing username!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        return;
    }
    
    if([[_mailEdit text] length] == 0)
    {
        NSLog(@"e-mail empty");
        [_mailEdit becomeFirstResponder];
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Missing e-mail!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        return;
    }
    
    if([[_passEdit text] length] == 0)
    {
        NSLog(@"password empty");
        [_passEdit becomeFirstResponder];
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Missing password!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        return;
    }

    if(![STUtilities isMailAddressValid:[_mailEdit text]])
    {
        NSLog(@"email address invalid");
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Email address invalid!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        [_mailEdit becomeFirstResponder];
        
        return;
    }

    //matches

    if(![[_mailEdit text] isEqualToString:[_confirmMailEdit text] ])
    {
        NSLog(@"email addresses do not match");
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Email addresses do not match!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        [_mailEdit becomeFirstResponder];
        
        return;
    }
    
    if(![[_passEdit text] isEqualToString:[_confirmPassEdit text] ])
    {
        NSLog(@"Passwords do not match");
        
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Passwords do not match!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        
        [_passEdit becomeFirstResponder];
        
        return;
    }
    
    NSDictionary *postDict = @{@"name" : [_nameEdit text],
                               @"email" : [_mailEdit text],
                               @"password" : [_passEdit text],
                               @"secret" : APP_SECRET
                               };
    
    [[STNetworkManager managerWithDelegate:self] requestRegisterNormal:postDict];
    
    [SVProgressHUD showWithStatus:@"Registering..." maskType:SVProgressHUDMaskTypeGradient];
}

#pragma mark - Network Delegate


-(void)downloadResponse:(id)responseObject message:(NSString *)message{
    
    NSLog(@"%@", responseObject);
    NSLog(@"%@", message);
    
    [SVProgressHUD dismiss];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    MY_DELAY_MAIN_QUEUE(0.6, ^{ //delay for controller change
        
            [TSMessage showNotificationInViewController:[MY_APP_DELEGATE loginViewController] title:@"Success" subtitle:@"Registration successful" type:TSMessageNotificationTypeSuccess duration:4.0 canBeDismissedByUser:YES];
    });

}

-(void)downloadFailureCode:(int)errCode message:(NSString *)message{
    
    NSLog(@"error %@", message);
    
    [SVProgressHUD dismiss];
    
    [TSMessage showNotificationInViewController:self title:@"Error" subtitle:message type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
}

- (IBAction)closeRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
