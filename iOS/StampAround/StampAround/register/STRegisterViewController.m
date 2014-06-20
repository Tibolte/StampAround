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
                                                           beginColor:MY_UICOLOR_FROM_HEX_RGB(0xdbe9e9)
                                                             endColor:MY_UICOLOR_FROM_HEX_RGB(0xfffde5)
                                                                 type:STUTILITIES_TYPE_TOP_TO_BOTTOM];
    [[self view] addSubview:gradientBackground];
    [[self view] sendSubviewToBack:gradientBackground];
    
    [self setViewItems];

    
    NSDictionary *postDict = @{@"name" : @"Tibo",
                               @"email" : @"tibo@gmail.com",
                               @"password" : @"1234",
                               @"secret" : @"3744a7b11dd1183658c2381c30617fcb"
                               
                               };
    
    //register then
    //[[STNetworkManager managerWithDelegate:self] requestRegisterNormal:postDict];
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
    [_nameEdit setFont:[UIFont fontWithName:@"DINEngschriftStd" size:20.0f]];
    _nameEdit.delegate = self;
    
    _mailEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _mailEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_mailEdit setFont:[UIFont fontWithName:@"DINEngschriftStd" size:20.0f]];
    _mailEdit.delegate = self;
    
    _confirmMailEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm e-mail" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _confirmMailEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_confirmMailEdit setFont:[UIFont fontWithName:@"DINEngschriftStd" size:20.0f]];
    _confirmMailEdit.delegate = self;
    
    _passEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _passEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_passEdit setFont:[UIFont fontWithName:@"DINEngschriftStd" size:20.0f]];
    [_passEdit setSecureTextEntry:YES];
    _passEdit.delegate = self;
    
    _confirmPassEdit.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm password" attributes:@{NSForegroundColorAttributeName: MY_UICOLOR_FROM_HEX_RGB(0x858688)}];
    _confirmPassEdit.textColor = MY_UICOLOR_FROM_HEX_RGB(0x858688);
    [_confirmPassEdit setFont:[UIFont fontWithName:@"DINEngschriftStd" size:20.0f]];
    [_confirmPassEdit setSecureTextEntry:YES];
    _confirmPassEdit.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    
    //TODO: move
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
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
