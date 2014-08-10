//
//  STStore.h
//  StampAround
//
//  Created by Thibault on 10/08/14.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STStore : NSObject

@property(nonatomic) int storeId;
@property(nonatomic) int categoryId;
@property(nonatomic) int companyId;
@property(nonatomic) BOOL isActive;
@property(nonatomic,strong) NSString *description;
@property(nonatomic,strong) NSString *lat;
@property(nonatomic,strong) NSString *lon;
@property(nonatomic,strong) NSString *name;

-(id)initWithDict:(NSDictionary*)dict;

@end
