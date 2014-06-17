//
//  STUtilities.h
//  StampAround
//
//  Created by Thibault Guégan on 17/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STUtilities : NSObject

+(UIImageView*)imageViewWithFrame:(CGRect)frame beginColor:(UIColor*)beginColor endColor:(UIColor*)endColor type:(int)type;

+(BOOL)isMailAddressValid:(NSString *)checkString;

@end

#define STUTILITIES_TYPE_LEFT_TO_RIGHT  0
#define STUTILITIES_TYPE_TOP_TO_BOTTOM  1