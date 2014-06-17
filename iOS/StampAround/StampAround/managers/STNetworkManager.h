//
//  STNetworkManager.h
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol STNetworkManagerDelegate <NSObject>

@required
-(void)downloadResponse:(id)responseObject message:(NSString*)message;
-(void)downloadFailureCode:(int)errCode message:(NSString*)message;
@optional

@end

@interface STNetworkManager : NSObject

@property(nonatomic, weak) id<STNetworkManagerDelegate> delegate;

+(id)managerWithDelegate:(id)delegate;

- (void)requestAuthenticate:(NSString *)username password:(NSString *)password;

@end

#define STATUS_OK           200