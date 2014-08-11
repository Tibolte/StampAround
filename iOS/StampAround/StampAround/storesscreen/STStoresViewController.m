//
//  STStoresViewController.m
//  StampAround
//
//  Created by Thibault on 09/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STStoresViewController.h"
#import <UIView+MTAnimation.h>
#import <ZFModalTransitionAnimator.h>

@interface STStoresViewController ()

@property (nonatomic, strong) ZFModalTransitionAnimator *animator;

@end

@implementation STStoresViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f6f0)];
    
    // back gesture
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBackGesture:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeGestureRecognizer];
    [swipeGestureRecognizer setDelegate:self];
    
    [[STNetworkManager managerWithDelegate:self] requestStoresByCategory:_categoryId];
    
    UINib *cellNib = [UINib nibWithNibName:@"STStoreCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"STStoreCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    _bottomBar.delegate = self;
    
    [self.collectionView setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f6f0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Actions

-(void)swipeBackGesture:(UIGestureRecognizer*)gesture{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ST Bottom bar delegate

- (void)mapClicked
{
    
}

- (void)stampClicked
{
    // create the scanning view controller and a navigation controller in which to present it:
    CDZQRScanningViewController *scanningVC = [CDZQRScanningViewController new];
    UINavigationController *scanningNavVC = [[UINavigationController alloc] initWithRootViewController:scanningVC];
    
    // configure the scanning view controller:
    scanningVC.resultBlock = ^(NSString *result) {
        //field.text = result;
        NSLog(@"Scanning result: %@", result);
        [scanningNavVC dismissViewControllerAnimated:YES completion:nil];
    };
    scanningVC.cancelBlock = ^() {
        [scanningNavVC dismissViewControllerAnimated:YES completion:nil];
    };
    scanningVC.errorBlock = ^(NSError *error) {
        // todo: show a UIAlertView orNSLog the error
        [TSMessage showNotificationInViewController:self title:@"Error" subtitle:@"Failed to scan QR Code!" type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
        [scanningNavVC dismissViewControllerAnimated:YES completion:nil];
    };
    
    // present the view controller full-screen on iPhone; in a form sheet on iPad:
    scanningNavVC.modalPresentationStyle = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
    [self presentViewController:scanningNavVC animated:YES completion:nil];

}

- (void)myCardsClicked
{
    STMyCardsViewController *controller = [[STMyCardsViewController alloc] init];
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:controller];
    
    self.animator.dragable = YES;
    [self.animator setContentScrollView:controller.collectionView];
    self.animator.direction = ZFModalTransitonDirectionBottom;
    
    controller.transitioningDelegate = self.animator;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    int count = 0;
    if([_arrStores count] % 2 == 0)
    {
        count = (int)[_arrStores count]/2;
    }
    else
    {
        count = (int)([_arrStores count]/2 + 1);
    }
    
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    STStoreCell *storeCell = [cv dequeueReusableCellWithReuseIdentifier:@"STStoreCell" forIndexPath:indexPath];
    if(!storeCell){
        storeCell = [[STStoreCell alloc] init];
    }
    
    return storeCell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:1.0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0], nil];
    bounceAnimation.duration = 0.3;
    bounceAnimation.removedOnCompletion = NO;
    [cell.layer addAnimation:bounceAnimation forKey:@"bounce"];
    
    cell.layer.transform = CATransform3DIdentity;
    
    STStampCardViewController *controller = [[STStampCardViewController alloc] init];
    controller.store = _arrStores[2*indexPath.section + indexPath.row];
    
    MY_DELAY_MAIN_QUEUE(0.2, ^{ //delay for controller change
        [self.navigationController pushViewController:controller animated:YES];
    });
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Deselect item
}


#pragma mark - Network Delegate


-(void)downloadResponse:(id)responseObject message:(NSString *)message{
    
    NSLog(@"%@", responseObject);
    NSLog(@"%@", message);
    
    NSArray *arrStoresAll = responseObject[@"results"];
    NSMutableArray *arrTmpStores = [[NSMutableArray alloc] init];
    for (int i=0; i<[arrStoresAll count]; i++)
    {
        NSDictionary *store = arrStoresAll[i];
        STStore *storeObject = [[STStore alloc] initWithDict:store];
        [arrTmpStores addObject:storeObject];
    }
    _arrStores = [NSArray arrayWithArray:arrTmpStores];
    
    [self.collectionView reloadData];
    
    NSLog(@"array of stores: %@", _arrStores);
}

-(void)downloadFailureCode:(int)errCode message:(NSString *)message{
    
    NSLog(@"error %@", message);
    
    [TSMessage showNotificationInViewController:self title:@"Error" subtitle:message type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];
    
}


@end