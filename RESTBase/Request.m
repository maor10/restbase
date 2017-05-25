 //
//  Request.m
//  MyClubz
//
//  Created by Maor Kern on 8/20/15.
//  Copyright (c) 2015 Maor Kern. All rights reserved.
//

#import "Request.h"
#define API_TOKEN @"M477[LVV82"


@implementation Request
@synthesize success,failure,completion;
+(void)initialize{
    [[Header requestSerializer] setValue:API_TOKEN forHTTPHeaderField:@"apitoken"];
    [[Header responseSerializer] setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
}

+(void)checkForResponseError:(NSArray*)response{
    if(response == nil){
        NSLog(@"nil response");
        #ifdef DEBUG
            [NSException raise:@"Error 500" format:@"Check the logs for more information"];
        #endif
    }
}


#pragma mark - Asynchronous methods

+(Request*)request{
    Request *request = [[Request alloc] init];
    
    request.success = ^(AFHTTPRequestOperation *operation, id responseObj) {
        NSLog(@"Success on operation %@ with result %@", [operation.request.URL absoluteString], operation.responseString);
        NSArray *result = responseObj;
        [Request checkForResponseError:result];
        request.completion(result);
    };
    
    request.failure = ^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@, result %@", error.localizedDescription, operation.responseString);
        [NSException raise:@"Get with action failed" format:@"Link %@ Failed with objective c error: %@", [operation.request.URL absoluteString], error];
    };
    
    return request;
}
-(AFHTTPRequestOperationManager*)getWithAction:(NSString *)action parameters:(NSDictionary*)params success:(void (^)(NSArray*))c{
    NSLog(@"Getting with action %@ and params %@", action, params);
    
    completion = c;
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    NSLog(@"%@%@", BASE_URL, action);
    [manager GET:[NSString stringWithFormat:@"%@%@", BASE_URL, action]  parameters:params success:success failure:failure];

    return manager;
}

-(AFHTTPRequestOperationManager*)postWithAction:(NSString *)action parameters:(NSDictionary*)params success:(void (^)(NSArray*))c{
    completion = c;
    NSLog(@"Posting with action %@ and params %@", action, params);
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    
    [manager POST:[NSString stringWithFormat:@"%@%@", BASE_URL, action]  parameters:params success:success failure:failure];
    
    return manager;
}

-(AFHTTPRequestOperationManager*)putWithAction:(NSString *)action parameters:(NSDictionary*)params success:(void (^)(NSArray*))c{
    completion = c;
    NSLog(@"Putting with action %@ and params %@", action, params);
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    
    [manager PUT:[NSString stringWithFormat:@"%@%@", BASE_URL, action]  parameters:params success:success failure:failure];
    
    return manager;
}

-(AFHTTPRequestOperationManager*)deleteWithAction:(NSString *)action paramaters:(NSDictionary*)params success:(void (^)(NSArray*))c{
    completion = c;
    NSLog(@"Deleting with action %@ and params %@", action, params);
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    
    [manager DELETE:[NSString stringWithFormat:@"%@%@", BASE_URL, action]  parameters:params success:success failure:failure];
    
    return manager;
}

#pragma mark - Synchronous methods

+(NSArray*)getSynchronouslyWithAction:(NSString *)action andParams:(NSDictionary*)params{
    NSLog(@"Getting with action %@ and params %@", action, params);
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    
    NSError *error = nil;
    AFHTTPRequestOperation *operation = nil;
    
    NSArray *result = [manager syncGET:[NSString stringWithFormat:@"%@%@", BASE_URL, action] parameters:params operation:&operation error:nil];
    
    if (error) {
        NSLog(@"Error: %@, result %@", error.localizedDescription, operation.responseString);
        [NSException raise:@"Get with action failed" format:@"Link %@%@ Failed with objective c error: %@", BASE_URL, action, error];
        return nil;
    }
    
    NSLog(@"%@", operation.responseString);
    [Request checkForResponseError:result];
    
    return result;
}

+(BOOL)postSynchronouslyWithAction:(NSString *)action andParams:(NSDictionary *)params{
    NSLog(@"Posting with action %@ and params %@", action, params);
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    
    NSError *error = nil;
    AFHTTPRequestOperation *operation = nil;
    NSArray *result = [manager syncPOST:[NSString stringWithFormat:@"%@%@", BASE_URL, action] parameters:params operation:&operation error:&error];
    if (error) {
        NSLog(@"Error: %@, result %@", error.localizedDescription, operation.responseString);
        return NO;
    }
    NSLog(@"ResultP %@", result);
    [Request checkForResponseError:result];
    
    return YES;
}

+(BaseEntity*)putSynchronouslyWithAction:(NSString *)action andParams:(NSDictionary *)params{
    NSLog(@"Putting with action %@ and params %@", action, params);
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    
    NSError *error = nil;
    NSArray *result = [manager syncPUT:[NSString stringWithFormat:@"%@%@", BASE_URL, action] parameters:params operation:NULL error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
        return nil;
    }
    
    NSLog(@"ResultP %@", result);
    [Request checkForResponseError:result];
    
    return [result objectAtIndex:0];
}

+(BOOL)deleteSynchronouslyWithAction:(NSString *)action{
    NSLog(@"Deleting with action %@", action);
    AFHTTPRequestOperationManager *manager = [Header requestOperationManager];
    
    NSError *error = nil;
    NSArray *result = [manager syncDELETE:[NSString stringWithFormat:@"%@%@", BASE_URL, action] parameters:nil operation:NULL error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
        return NO;
    }
    
    [Request checkForResponseError:result];
    
    return YES;
}
@end
