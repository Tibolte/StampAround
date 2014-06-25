//
//  STCategoriesViewController.h
//  StampAround
//
//  Created by Thibault Guégan on 16/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBottomBar.h"

@interface STCategoriesViewController : UIViewController<STBottomBarProtocol>

@property (weak, nonatomic) IBOutlet STBottomBar *bottomBar;
@end
