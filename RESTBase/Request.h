//
//  Request.h
//  MyClubz
//
//  Created by Maor Kern on 8/20/15.
//  Copyright (c) 2015 Maor Kern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <AFNetworking-Synchronous/AFHTTPRequestOperationManager+Synchronous.h>
#import "Header.h"

#define BASE_URL @"http://139.59.159.64/index.php/"
#define IMAGES_URL @"http://myclubz.club/myclubzadmin/"

@class BaseEntity;
@interface Request : NSObject{
    void (^success)(AFHTTPRequestOperation *operation, id responseObj);
    void (^failure)(AFHTTPRequestOperation *operation, NSError * error);
    void (^completion)(id);
}

@property(nonatomic, strong) void (^success)(AFHTTPRequestOperation *operation, id responseObj);
@property(nonatomic, strong) void (^failure)(AFHTTPRequestOperation *operation, NSError * error);
@property(nonatomic, strong) void (^completion)(id);

/**
 * Asynchronous get request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @param params - Sends the dictionary parameters as get parameters.
 * @return an array, which should be [[content], error]
 **/
-(AFHTTPRequestOperationManager*)getWithAction:(NSString *)action parameters:(NSDictionary*)params success:(void (^)(NSArray*))c;

/**
 * Asynchronous post request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @param params - Sends the dictionary parameters as post parameters.
 * @return an array, which should be [[content], error]
 **/
-(AFHTTPRequestOperationManager*)postWithAction:(NSString *)action parameters:(NSDictionary*)params success:(void (^)(NSArray*))c;

/**
 * Asynchronous put request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @param params - Sends the dictionary parameters as put parameters.
 * @return an array, which should be [[content], error]
 **/
-(AFHTTPRequestOperationManager*)putWithAction:(NSString *)action parameters:(NSDictionary*)params success:(void (^)(NSArray*))c;

/**
 * Asynchronous delete request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @param params - Sends the dictionary parameters as put parameters.
 * @return an array, which should be [[content], error]
 **/
-(AFHTTPRequestOperationManager*)deleteWithAction:(NSString *)action paramaters:(NSDictionary*)params success:(void (^)(NSArray*))c;


/**
 * Initializes a request with a success and failure block
 * @return Request
 **/
+(Request*)request;

/**
 * Run's a synchronous get request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @param params - Sends the dictionary parameters as get parameters.
 * @return an array, which should be [[content], error]
 **/
+(NSArray*)getSynchronouslyWithAction:(NSString*)action andParams:(NSDictionary*)params;

/**
 * Run's a synchronous post request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @param params - Sends the dictionary parameters as post parameters.
 * @return success
 **/
+(BOOL)postSynchronouslyWithAction:(NSString*)action andParams:(NSDictionary*)params;

/**
 * Run's a synchronous put request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @param params - Sends the dictionary parameters as put parameters.
 * @return the entity updated
 **/
+(BaseEntity*)putSynchronouslyWithAction:(NSString*)action andParams:(NSDictionary*)params;

/**
 * Run's a synchronous delete request to the server with the URL BASE_URL + action.
 * This method throws exceptions if the server returns an error, and in development mode will send exceptions on no content.
 * @return success
 **/
+(BOOL)deleteSynchronouslyWithAction:(NSString*)action;


@end
