//
//  STBottomBar.m
//  StampAround
//
//  Created by Thibault Guégan on 25/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STBottomBar.h"

@implementation STBottomBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) awakeAfterUsingCoder:(NSCoder*)aDecoder {
    BOOL isJustAPlaceholder = ([[self subviews] count] == 0);
    if (isJustAPlaceholder) {
        STBottomBar* theRealThing = [[self class] loadFromNib];
        
        theRealThing.frame = self.frame;    // ... (pass through selected properties)
        
        return theRealThing;
    }
    return self;
}

+ (id) loadFromNib {
	NSString* nibName = NSStringFromClass([self class]);
	NSArray* elements = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	for (NSObject* anObject in elements) {
		if ([anObject isKindOfClass:[self class]]) {
			return anObject;
		}
	}
	return nil;
}

- (IBAction)btnMapClicked:(id)sender {
    NSLog(@"btn map clicked");
    
    [_delegate mapClicked];
}

- (IBAction)btnStampClicked:(id)sender {
    NSLog(@"btn stamp clicked");

    [_delegate stampClicked];
}

- (IBAction)btnMyCardsClicked:(id)sender {
    NSLog(@"btn my cards clicked");

    [_delegate myCardsClicked];
}

- (void)awakeFromNib
{
    //set properties
    _btnMap.titleLabel.font = [UIFont fontWithName:@"DINNextRoundedLTPro-Medium" size:17.0f];
    _btnStamp.titleLabel.font = [UIFont fontWithName:@"DINNextRoundedLTPro-Medium" size:17.0f];
    _btnMyCards.titleLabel.font = [UIFont fontWithName:@"DINNextRoundedLTPro-Medium" size:17.0f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
