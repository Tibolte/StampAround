//
//  MyLocation.h
//  StampAround
//
//  Created by Thibault Guégan on 19/08/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end
