//
//  STButton.m
//  StampAround
//
//  Created by Thibault Guégan on 17/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STButton.h"

@implementation STButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    
    self = [super initWithCoder:aDecoder];
    
    [[self titleLabel] setTextColor:[UIColor whiteColor]];
    
    [self setAdjustsImageWhenHighlighted:NO];
    
    return self;
}


-(void)initWithType:(int)type string:(NSString*)label{
    
    [self setTitle:label forState:UIControlStateNormal];
    
    CGRect frame = [self frame];
    UIImageView *background;
    UIImageView *backgroundTouch;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(3.0f, 0.0f, 0.0f, 0.0f)];
    
    //rounded corners
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                                         cornerRadii:CGSizeMake(5.0f, 5.0f)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    switch (type) {

        case ST_BUTTON_TYPE_ORANGE:
            background = [STUtilities imageViewWithFrame:frame
                                              beginColor:MY_UICOLOR_FROM_HEX_RGB(0xd86947)
                                                endColor:MY_UICOLOR_FROM_HEX_RGB(0xe48e73)
                                                    type:STUTILITIES_TYPE_TOP_TO_BOTTOM];
            backgroundTouch = [STUtilities imageViewWithFrame:frame
                                                   beginColor:MY_UICOLOR_FROM_HEX_RGB(0xbb5b3d)
                                                     endColor:MY_UICOLOR_FROM_HEX_RGB(0xc17861)
                                                         type:STUTILITIES_TYPE_TOP_TO_BOTTOM];
            [[self titleLabel] setFont:[UIFont fontWithName:@"DINEngschriftStd" size:kButtonFontSize]];
            break;
            
        case ST_BUTTON_TYPE_FB:
            background = [STUtilities imageViewWithFrame:frame
                                              beginColor:MY_UICOLOR_FROM_HEX_RGB(0x2c6099)
                                                endColor:MY_UICOLOR_FROM_HEX_RGB(0x1269ad)
                                                    type:STUTILITIES_TYPE_TOP_TO_BOTTOM];
            backgroundTouch = [STUtilities imageViewWithFrame:frame
                                                   beginColor:MY_UICOLOR_FROM_HEX_RGB(0x1f446c)
                                                     endColor:MY_UICOLOR_FROM_HEX_RGB(0x0e5186)
                                                         type:STUTILITIES_TYPE_TOP_TO_BOTTOM];
            [[self titleLabel] setFont:[UIFont fontWithName:@"DINEngschriftStd" size:kButtonFontSize]];
            
            //create an image
            UIImage *fbImage = [UIImage imageNamed:@"facebook_logo.png"];
            
            //image view instance to display the image
            UIImageView *fbImageView = [[UIImageView alloc] initWithImage:fbImage];
            
            //set the frame for the image view
            CGRect myFrame = CGRectMake(16.0f, 14.0f, fbImageView.frame.size.width,
                                        fbImageView.frame.size.height/2);
            [fbImageView setFrame:myFrame];
            
            //If your image is bigger than the frame then you can scale it
            [fbImageView setContentMode:UIViewContentModeScaleAspectFit];
            
            //add the image view to the current view
            [self addSubview:fbImageView];
            
            break;
    }
    
    [self setBackgroundImage:[background image] forState:UIControlStateNormal];
    [self setBackgroundImage:[backgroundTouch image] forState:UIControlStateHighlighted];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = [self titleLabel].frame;
    frame.size.height = [self bounds].size.height;
    frame.origin.y = [self titleEdgeInsets].top;
    [[self titleLabel] setFrame:frame];
}

@end
