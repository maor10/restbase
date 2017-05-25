//
//  Header.h
//  MyClubz
//
//  Created by Maor Kern on 8/21/15.
//  Copyright (c) 2015 Maor Kern. All rights reserved.
//

#import <AFNetworking.h>

@interface Header : NSObject

+ (AFHTTPRequestOperationManager *)requestOperationManager;
+ (AFHTTPRequestSerializer *)requestSerializer;
+ (AFHTTPResponseSerializer *)responseSerializer;
@end
