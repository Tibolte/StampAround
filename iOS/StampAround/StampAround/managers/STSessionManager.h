//
//  STSessionManager.h
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STSessionManager : NSObject

+(id)manager;

-(NSString*)username;
-(NSString*)token;
-(NSString*)secret;

-(void)saveCredentialsWithUsername:(NSString*)username token:(NSString*)token secret:(NSString*)secret;

@end
