//
//  STMapViewController.h
//  StampAround
//
//  Created by Thibault on 11/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "STNetworkManager.h"
#import "STStore.h"
#import "MyLocation.h"

#import <CoreLocation/CoreLocation.h>

@interface STMapViewController : UIViewController<UIGestureRecognizerDelegate, CLLocationManagerDelegate, STNetworkManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *fakeView;
@property(nonatomic, strong) NSArray *arrStores;

@end
