//
//  STMapViewController.m
//  StampAround
//
//  Created by Thibault on 11/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STMapViewController.h"

@interface STMapViewController ()

@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation STMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [_locationManager setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // back gesture
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownGesture:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [_fakeView addGestureRecognizer:swipeGestureRecognizer];
    [swipeGestureRecognizer setDelegate:self];
    [_mapView setDelegate:self];
    
    [_locationManager startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //we deal only with Rvk for now
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 64.135716;
    zoomLocation.longitude= -21.895498;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 8000, 8000);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
}

#pragma mark - User Actions

-(void)swipeDownGesture:(UIGestureRecognizer*)gesture{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Network Delegate

-(void)downloadResponse:(id)responseObject message:(NSString *)message{
    
    NSLog(@"%@", responseObject);
    NSLog(@"%@", message);
    
    NSArray *arrStoresAll = responseObject[@"results"];
    NSMutableArray *arrTmpStores = [[NSMutableArray alloc] init];
    for (int i=0; i<[arrStoresAll count]; i++)
    {
        NSDictionary *store = arrStoresAll[i]; //crash
        STStore *storeObject = [[STStore alloc] initWithDict:store];
        [arrTmpStores addObject:storeObject];
    }
    _arrStores = [NSArray arrayWithArray:arrTmpStores];
    
    NSLog(@"%@", _arrStores.description);
    
    [self plotMapAnnotations];
}

-(void)downloadFailureCode:(int)errCode message:(NSString *)message{
    
    NSLog(@"error %@", message);
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    NSLog(@"location: %f %f (acc: %f)",newLocation.coordinate.latitude,newLocation.coordinate.longitude, [newLocation horizontalAccuracy]);
    
    [_locationManager stopUpdatingLocation];
    
    [[STNetworkManager managerWithDelegate:self] requestStoresByLocation:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude radius:10];
}

#pragma mark - Map annotations drawing

- (void)plotMapAnnotations
{
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    
    for(STStore *store in _arrStores)
    {
        NSString *lat = store.lat;
        NSString *lon = store.lon;
        NSString *address = store.address;
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [lat floatValue];
        coordinate.longitude = [lon floatValue];
        
        MyLocation *annotation = [[MyLocation alloc] initWithName:store.name address:address coordinate:coordinate] ;
        [_mapView addAnnotation:annotation];
    }
}

#pragma mark - MKMapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]])
    {
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"icon_map_store"];//here we use a nice image instead of the default pins
            //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
