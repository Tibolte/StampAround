//
//  STStoresViewController.h
//  StampAround
//
//  Created by Thibault on 09/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBottomBar.h"

@interface STStoresViewController : UIViewController<STBottomBarProtocol,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet STBottomBar *bottomBar;
@end
