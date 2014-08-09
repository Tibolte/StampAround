//
//  STNetworkManager.m
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STNetworkManager.h"

#define METHOD_GET  0
#define METHOD_POST 1

@interface STNetworkManager()

-(void)showError:(NSError*)err;

@end

@implementation STNetworkManager

#pragma mark - General Methods

+(id)manager{
    static STNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+(id)managerWithDelegate:(id)delegate{
    
    STNetworkManager *manager = [STNetworkManager manager];
    
    if(delegate){
        [manager setDelegate:delegate];
    }
    return manager;
}

-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

#pragma mark - Requests Unified

-(void)unifiedRequest:(NSString*)restUrl method:(int)method dict:(NSDictionary*)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    void (^blckSuccess)(AFHTTPRequestOperation *operation, id responseObject);
    void (^blckFailure)(AFHTTPRequestOperation *operation, NSError *error);
    
    blckSuccess = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //do stuff related to status code
        if([[responseObject objectForKey:@"status"] intValue]==STATUS_OK)
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            [_delegate downloadResponse:[NSDictionary dictionaryWithDictionary:dict] message:[responseObject objectForKey:@"message"]];
        }
        
        else //get error and display it to app
        {
            [_delegate downloadFailureCode:[[responseObject objectForKey:@"status"] intValue] message:[responseObject objectForKey:@"message"]];
        }
        
    };
    
    
    blckFailure = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self showError:error];
        
        [_delegate downloadFailureCode:-1 message:@"Connection error"];
        
        //connection error (no network) //freeze app?
    };
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",URL_BASE,restUrl];
    NSLog(@"url: %@",fullUrl);
    if(method == METHOD_GET){
        [manager GET:fullUrl parameters:dict success:blckSuccess failure:blckFailure];
    }
    else if(method == METHOD_POST){
        [manager POST:fullUrl parameters:dict success:blckSuccess failure:blckFailure];
    }
}

#pragma mark - Requests Specific

- (void)requestAuthenticate:(NSString *)username password:(NSString *)password
{
    NSString *restUrl       = [NSString stringWithFormat:URL_AUTHENTICATE,username,password];
    
    [self unifiedRequest:restUrl method:METHOD_GET dict:nil];
}

- (void)requestRegisterFacebook:(NSDictionary*)postDict
{
    NSString *restUrl = URL_REGISTER_FB;
    
    [self unifiedRequest:restUrl method:METHOD_POST dict:postDict];
}

- (void)requestRegisterNormal:(NSDictionary*)postDict
{
    NSString *restUrl = URL_REGISTER;
    
    [self unifiedRequest:restUrl method:METHOD_POST dict:postDict];
}

- (void)requestSessionValid:(NSString *)token secret:(NSString *)secret
{
    NSString *restUrl       = [NSString stringWithFormat:URL_SESSION_VALID,token,secret];
    
    [self unifiedRequest:restUrl method:METHOD_GET dict:nil];
}

- (void)requestCategories
{
    [self unifiedRequest:URL_CATEGORIES method:METHOD_GET dict:nil];
}

- (void)requestStoresByCategory:(int)category
{
    NSString *restUrl       = [NSString stringWithFormat:URL_STORES,category];
    
    [self unifiedRequest:restUrl method:METHOD_GET dict:nil];
}

#pragma mark - Error Messages

-(void)showError:(NSError*)err{
    
    NSLog(@"NetworkManager err: %@",err);
}

@end
