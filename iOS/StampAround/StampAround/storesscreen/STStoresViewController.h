//
//  STStoresViewController.h
//  StampAround
//
//  Created by Thibault on 09/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBottomBar.h"
#import "STNetworkManager.h"

@interface STStoresViewController : UIViewController<STBottomBarProtocol,UIGestureRecognizerDelegate,STNetworkManagerDelegate>

@property (strong, nonatomic) IBOutlet STBottomBar *bottomBar;
@property(nonatomic) int categoryId;

@end
