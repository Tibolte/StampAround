//
//  STConstants.h
//  StampAround
//
//  Created by Thibault Guégan on 15/06/2014.
//  Copyright (c) 2014 StampAround. All rights reserved.
//

#ifndef StampAround_STConstants_h
#define StampAround_STConstants_h

// NETWORK COMMUNICATION:
#define URL_BASE            @"http://api.stampy.adamenvy.com/"
#define URL_AUTHENTICATE    @"user/authenticate?user=%@&pass=%@"
#define URL_SESSION_VALID   @"user/session/valid?token=%@&secret=%@"
#define URL_REGISTER_FB     @"user/register/facebook"
#define URL_REGISTER        @"user/register/normal"
#define URL_CATEGORIES      @"categories/all"
#define URL_STORES          @"stores/category/%d"

#define APP_SECRET          @"3744a7b11dd1183658c2381c30617fcb"

#endif
