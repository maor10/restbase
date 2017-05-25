//
//  Header.m
//  MyClubz
//
//  Created by Maor Kern on 8/21/15.
//  Copyright (c) 2015 Maor Kern. All rights reserved.
//

#import "Header.h"

@implementation Header


+ (AFHTTPRequestOperationManager *)requestOperationManager{
    static AFHTTPRequestOperationManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [AFHTTPRequestOperationManager manager];
        
        [sharedSingleton setRequestSerializer:[Header requestSerializer]];
        [sharedSingleton setResponseSerializer:[Header responseSerializer]];
        return sharedSingleton;
    }
    
    
}

+ (AFHTTPRequestSerializer *)requestSerializer
{
    static AFHTTPRequestSerializer *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[AFHTTPRequestSerializer alloc] init];
        
        return sharedSingleton;
    }
}
 
+ (AFHTTPResponseSerializer *)responseSerializer
{
    static AFJSONResponseSerializer *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [AFJSONResponseSerializer serializer];
        
        return sharedSingleton;
    }
}
@end
