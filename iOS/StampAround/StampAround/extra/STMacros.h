//
//  STMacros.h
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#ifndef StampAround_STMacros_h
#define StampAround_STMacros_h

// HW and SW version check
#define MY_IS_IOS6	            ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define MY_IS_IOS7	            ([[[UIDevice currentDevice] systemVersion] intValue]==7)
#define MY_IS_IOS6_OR_NEWER	    ([[[UIDevice currentDevice] systemVersion] floatValue]>=6)
#define MY_IS_IOS7_OR_NEWER	    ([[[UIDevice currentDevice] systemVersion] floatValue]>=7)
#define MY_IS_IPAD              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define MY_IS_IPHONE            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define MY_IS_RETINA            (([[UIScreen mainScreen] respondsToSelector:@selector(scale)])&&([[UIScreen mainScreen] scale] >= 2))
#define MY_SCREEN_SIZE			[[UIScreen mainScreen] bounds].size
#define MY_IS_SCREENHEIGHT_480  ([[UIScreen mainScreen] bounds].size.height==480)
#define MY_IS_SCREENHEIGHT_568  ([[UIScreen mainScreen] bounds].size.height==568)
#define MY_DEVICE_UDID          ([UIDevice currentDevice].uniqueIdentifier)

// colors
#define MY_UICOLOR_FROM_HEX_RGB(rgbValue)	[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define MY_UICOLOR_FROM_RGBA(r,g,b,a)		[UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define MY_UICOLOR_FROM_RGB(r,g,b)			MY_UICOLOR_FROM_RGBA(r, g, b, 1.0f)

// geometry
#define MY_CGRECT_FROM_CGPOINT_AND_CGSIZE(point,size)	CGRectMake(point.x, point.y, size.width, size.height)
#define MY_CGRECT_FROM_2_CGPOINTS(point1,point2)		CGRectMake(MIN(point1.x,point2.x), MIN(point1.y,point2.y), fabs(point1.x-point2.x), fabs(point1.y-point2.y))
#define MY_DEG_TO_RAD(degrees) ((degrees) * M_PI / 180.0)
#define MY_RAD_TO_DEG(radians) ((radians) * 180.0 / M_PI)

// threads
#define MY_DELAY_MAIN_QUEUE(delay, block)			MY_DELAY_SOME_QUEUE(delay, block, dispatch_get_main_queue())
#define MY_DELAY_SOME_QUEUE(delay, block, queue)	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (delay) * NSEC_PER_SEC), queue, block);
#define MY_BLOCK_IN_MAIN_QUEUE(block)				dispatch_async(dispatch_get_main_queue(), (block));

// logging
#define MY_STRING_FROM_BOOL(bool_value)	(bool_value)?@"YES":@"NO"
#define MY_FUNC_LOG                     NSLog(@"[Line %d] %s", __LINE__, __PRETTY_FUNCTION__);


// others
#define MY_APP_DELEGATE (STAppDelegate *)[[UIApplication sharedApplication] delegate]

#define REPAIR_OFFSET_FOR_IOS7  if([self respondsToSelector:@selector(edgesForExtendedLayout)]){ self.edgesForExtendedLayout = UIRectEdgeNone; }

#define MY_HIDE_STATUSBAR   [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

#define MY_IS_JSON_VALID(object,key)       (([object valueForKey:key])&&([object valueForKey:key]!=[NSNull null]))

#define MY_REMOVE_ALL_BADGES        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

// newers

#define MY_OPEN_LINK(link)    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
#define MY_STATUSBAR_LIGHT    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];       //View controller-based status bar appearance
#define MY_STATUSBAR_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height

#define MY_AVOID_WARNING_CAUSE_SELECTOR(code) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
code; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif

#define MY_CURRENT_LANGUAGE_BUNDLE [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:([[NSLocale preferredLanguages] count]>0)?[[NSLocale preferredLanguages] objectAtIndex:0]:@"is" ofType:@"lproj"]]
