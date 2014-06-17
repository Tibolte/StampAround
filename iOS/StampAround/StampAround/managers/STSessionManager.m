//
//  STSessionManager.m
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STSessionManager.h"

#define KEY_USERNAME        @"memory_key_username"
#define KEY_TOKEN           @"memory_key_token"

@interface STSessionManager()

@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *token;

@end

@implementation STSessionManager

+(id)manager{
    static STSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [manager loadCredentials];
    });
    return manager;
}

-(NSString*)username{
    return _username;
}

-(NSString*)token{
    return _token;
}

-(void)saveCredentialsWithUsername:(NSString*)username token:(NSString*)token
{
    
    if(username){
        _username = username;
    }
    if(token){
        _token = token;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:_username forKey:KEY_USERNAME];
    [[NSUserDefaults standardUserDefaults] setObject:_token    forKey:KEY_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadCredentials
{
    NSLog(@"loading from memory");
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERNAME]){
        _username = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERNAME];
    }
    else{   //default value
        _username = @"";
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN]){
        _token = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_TOKEN];
    }
    else{   //default value
        _token = @"";
    }

}

@end
