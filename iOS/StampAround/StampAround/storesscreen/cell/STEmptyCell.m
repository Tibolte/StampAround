//
//  STEmptyCell.m
//  StampAround
//
//  Created by Thibault Guégan on 20/08/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STEmptyCell.h"

@implementation STEmptyCell

-(id)init{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"STEmptyCell" owner:self options:nil] firstObject];
    
    [self.contentView setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f6f0)];
    
    return self;
    
}

@end
