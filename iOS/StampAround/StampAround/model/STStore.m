//
//  STStore.m
//  StampAround
//
//  Created by Thibault on 10/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import "STStore.h"

@implementation STStore

-(id)initWithDict:(NSDictionary*)dict;
{
    self = [super init];
    if(self)
    {
        _storeId = [dict[@"id"] intValue];
        _categoryId = [dict[@"categoryId"] intValue];
        _companyId = [dict[@"companyId"] intValue];
        _isActive = [dict[@"active"] boolValue];
        _description = dict[@"description"];
        _lat = dict[@"lat"];
        _lon = dict[@"lon"];
        _name = dict[@"name"];
        _email = dict[@"company"][@"email"];
        _address = dict[@"company"][@"address"];
        _phone = dict[@"company"][@"phone"];
    }
    
    return self;
}

@end
