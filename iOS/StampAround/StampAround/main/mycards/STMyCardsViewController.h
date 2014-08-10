//
//  STMyCardsViewController.h
//  StampAround
//
//  Created by Thibault on 10/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBottomBar.h"
#import "STNetworkManager.h"
#import "STStoreCell.h"
#import "STStore.h"

@interface STMyCardsViewController : UIViewController<STBottomBarProtocol,UIGestureRecognizerDelegate,STNetworkManagerDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet STBottomBar *bottomBar;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@end
