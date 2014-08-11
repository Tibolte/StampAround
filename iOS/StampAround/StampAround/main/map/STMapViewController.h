//
//  STMapViewController.h
//  StampAround
//
//  Created by Thibault on 11/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface STMapViewController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *fakeView;
@end
