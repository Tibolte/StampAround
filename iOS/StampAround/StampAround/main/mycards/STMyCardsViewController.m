//
//  STMyCardsViewController.m
//  StampAround
//
//  Created by Thibault on 10/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STMyCardsViewController.h"

@interface STMyCardsViewController ()

@end

@implementation STMyCardsViewController

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
    
    UINib *cellNib = [UINib nibWithNibName:@"STStoreCell" bundle:nil];
    UINib *cellEmptyNib = [UINib nibWithNibName:@"STEmptyCell" bundle:nil];

    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"STStoreCell"];
    [self.collectionView registerNib:cellEmptyNib forCellWithReuseIdentifier:@"STEmptyCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView setBackgroundColor:MY_UICOLOR_FROM_HEX_RGB(0xf4f6f0)];
    _lblNoCards.font = [UIFont fontWithName:@"DINNextRoundedLTPro-Medium" size:15.0f];
    _lblNoCards.hidden = YES;
    
    [[STNetworkManager managerWithDelegate:self] requestCards:[[STSessionManager manager] token]];
    
    [SVProgressHUD showWithStatus:@"Fetching cards..." maskType:SVProgressHUDMaskTypeGradient];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    int count = 2;
    if([_arrCards count] == 0)
    {
        count = 1; //display placeholder, to add a card
    }

    return count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    int count = 0;
    if([_arrCards count] == 0)
    {
        count = 1;
    }
    else if([_arrCards count] % 2 == 0)
    {
        count = (int)[_arrCards count]/2;
    }
    else
    {
        count = (int)([_arrCards count]/2 + 1);
    }
    
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([_arrCards count] == 0)
    {
        STEmptyCell *emptyCell = [cv dequeueReusableCellWithReuseIdentifier:@"STEmptyCell" forIndexPath:indexPath];
        if(!emptyCell){
            emptyCell = [[STEmptyCell alloc] init];
        }
        
        return emptyCell;
    }
    else
    {
        STStoreCell *storeCell = [cv dequeueReusableCellWithReuseIdentifier:@"STStoreCell" forIndexPath:indexPath];
        if(!storeCell){
            storeCell = [[STStoreCell alloc] init];
        }
        
        return storeCell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    // TODO: Select Item
    
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
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Deselect item
}

#pragma mark - Network Delegate


-(void)downloadResponse:(id)responseObject message:(NSString *)message{
    
    NSLog(@"%@", responseObject);
    NSLog(@"%@", message);
    
    [SVProgressHUD dismiss];
    
    NSArray *arrCardsAll = responseObject[@"results"];
    NSMutableArray *arrTmpCards = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[arrCardsAll count]; i++)
    {
        NSDictionary *card = arrCardsAll[i];
        STCard *cardObject = [[STCard alloc] initWithDict:card];
        [arrTmpCards addObject:cardObject];
    }
    _arrCards = [NSArray arrayWithArray:arrTmpCards];
    
    if([_arrCards count] == 0)
    {
        _lblNoCards.hidden = NO;
    }
    
    [self.collectionView reloadData];
}

-(void)downloadFailureCode:(int)errCode message:(NSString *)message{
    
    NSLog(@"error %@", message);
    
    [SVProgressHUD dismiss];
    
    [TSMessage showNotificationInViewController:self title:@"Error" subtitle:message type:TSMessageNotificationTypeError duration:4.0 canBeDismissedByUser:YES];    
}


@end
