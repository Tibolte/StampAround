//
//  STStoresViewController.h
//  StampAround
//
//  Created by Thibault on 09/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBottomBar.h"
#import "STNetworkManager.h"
#import "STStoreCell.h"
#import "STStore.h"
#import "STStampCardViewController.h"
#import "STMyCardsViewController.h"
#import <CDZQRScanningViewController.h>
#import "STMapViewController.h"

@interface STStoresViewController : UIViewController<STBottomBarProtocol,UIGestureRecognizerDelegate,STNetworkManagerDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//it's not necessary to list UICollectionViewDelegate 'cause UICollectionViewDelegateFlowLayout is actually a sub-protocol of UICollectionViewDelegate, so there is no need to list both.

@property (strong, nonatomic) IBOutlet STBottomBar *bottomBar;
@property(nonatomic) int categoryId;
@property(nonatomic, strong) NSArray *arrStores;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
