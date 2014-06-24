//
//  STRegisterViewController.h
//  StampAround
//
//  Created by Thibault Guégan on 17/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STNetworkManager.h"

@interface STRegisterViewController : UIViewController<STNetworkManagerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UITextField *nameEdit;
@property (weak, nonatomic) IBOutlet UIView *mailView;
@property (weak, nonatomic) IBOutlet UITextField *mailEdit;
@property (weak, nonatomic) IBOutlet UIView *confirmMailView;
@property (weak, nonatomic) IBOutlet UITextField *confirmMailEdit;
@property (weak, nonatomic) IBOutlet UIView *passView;
@property (weak, nonatomic) IBOutlet UITextField *passEdit;
@property (weak, nonatomic) IBOutlet UIView *confirmPassView;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassEdit;
@property (weak, nonatomic) IBOutlet STButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@end
