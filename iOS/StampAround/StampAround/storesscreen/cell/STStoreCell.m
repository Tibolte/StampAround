//
//  STStoreCell.m
//  StampAround
//
//  Created by Thibault on 09/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STStoreCell.h"

@implementation STStoreCell

-(id)init{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"STStoreCell" owner:self options:nil] firstObject];
    
    return self;
    
}

@end
