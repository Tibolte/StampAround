//
//  STUtilities.m
//  StampAround
//
//  Created by Thibault Guégan on 17/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STUtilities.h"

@implementation STUtilities

+(UIImageView*)imageViewWithFrame:(CGRect)frame beginColor:(UIColor*)beginColor endColor:(UIColor*)endColor type:(int)type{
    
    CGSize imageSize = frame.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)beginColor.CGColor, (id)endColor.CGColor, nil];
    
    //   set range 0~1
    //   two value, cause two color
    //   if more color, add more value
    CGFloat gradientLocation[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(gradientColors), gradientLocation);
    
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    CGContextSaveGState(context);
    [bezierPath addClip];
    
    //   set gradient start point and end point
    
    CGPoint beginPoint = CGPointZero;
    CGPoint endPoint   = CGPointZero;
    
    if(type==STUTILITIES_TYPE_TOP_TO_BOTTOM){
        beginPoint = CGPointMake(imageSize.width/2, 0);
        endPoint = CGPointMake(imageSize.width/2, imageSize.height);
    }
    else if(type==STUTILITIES_TYPE_LEFT_TO_RIGHT){
        beginPoint = CGPointMake(0, imageSize.height/2);
        endPoint = CGPointMake(imageSize.width, imageSize.height/2);
    }
    
    CGContextDrawLinearGradient(context, gradient, beginPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    
    UIImage * drawImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:drawImage];
    [imageView setFrame:frame];
    
    return imageView;
}

+(BOOL)isMailAddressValid:(NSString *)checkString{
    
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
