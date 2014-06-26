//
//  STButton.h
//  StampAround
//
//  Created by Thibault Guégan on 17/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STUtilities.h"
#import <QuartzCore/QuartzCore.h>

@interface STButton : UIButton

-(void)initWithType:(int)type string:(NSString*)label;

@end

#define ST_BUTTON_TYPE_ORANGE        0
#define ST_BUTTON_TYPE_FB            1
#define ST_BUTTON_TYPE_GRID          2

#define kButtonFontSize 22
#define kButtonGridFontSize 18

