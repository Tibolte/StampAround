//
//  STBottomBar.h
//  StampAround
//
//  Created by Thibault Guégan on 25/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STBottomBarProtocol <NSObject>

- (void)mapClicked;
- (void)stampClicked;
- (void)myCardsClicked;

@end

@interface STBottomBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *btnMap;
@property (weak, nonatomic) IBOutlet UIButton *btnStamp;
@property (weak, nonatomic) IBOutlet UIButton *btnMyCards;

@property (nonatomic, strong) id<STBottomBarProtocol>delegate;

@end
