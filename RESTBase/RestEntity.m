//
//  BaseEntity.m
//  MyClubz
//
//  Created by Maor Kern on 8/20/15.
//  Copyright (c) 2015 Maor Kern. All rights reserved.
//

#import "RestEntity.h"
#import <objc/runtime.h>
static NSString *prefix = nil;

@implementation RestEntity

#pragma mark - JSONModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"idS",
                                                       }];
}

#pragma Helper methods

+(NSString*)baseEntityURL{
    return (prefix == nil) ? [NSString stringWithFormat:@"%@s",[NSStringFromClass([self class]) lowercaseString]] :  [NSString stringWithFormat:@"%@/%@s",prefix, [NSStringFromClass([self class]) lowercaseString]];
}

+(void)setPrefix:(NSString *)p{
    prefix = p;
}

+(NSString*)getPrefix{
    return prefix;
}

#pragma mark - Asynchronous methods

-(AFHTTPRequestOperationManager*)getForId:(NSString*)idS completion:(void (^)(BaseEntity *))completion{
    NSLog(@"%@", [[self class] baseEntityURL], idS );
    NSString *encoded = [[NSString stringWithFormat:@"%@/%@", [[self class] baseEntityURL], idS]  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    return [[Request request] getWithAction:encoded parameters:nil success:^(NSArray* result){
        BaseEntity *entity = [[[self class] alloc]initWithDictionary:result[0] error:nil];
        [self initWithDictionary:result[0] error:nil];
        completion(entity);
    }];
}

+(AFHTTPRequestOperationManager*)getMany:(NSDictionary *)dictionary completion:(void (^)(NSArray *))completion{
    return  [[Request request] getWithAction:[NSString stringWithFormat:@"%@", [[self class] baseEntityURL]] parameters:dictionary success:^(NSArray* result){
        completion( [[self class] arrayOfModelsFromDictionaries:result]);
    }];
}

-(AFHTTPRequestOperationManager*)create:(void (^)(BaseEntity *))completion{
    NSDictionary *jsonDictionary = [self toDictionary];
    return [[Request request] postWithAction:[NSString stringWithFormat:@"%@", [[self class] baseEntityURL]] parameters:jsonDictionary success:^(NSArray* result){
        NSError *error;
        completion([self initWithDictionary:result[0] error:&error]);
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

-(AFHTTPRequestOperationManager*)update:(void (^)(BaseEntity *))completion{
    NSDictionary *jsonDictionary = [self toDictionary];
    return [[Request request] putWithAction:[NSString stringWithFormat:@"%@/%@", [[self class] baseEntityURL], self.idS] parameters:jsonDictionary success:^(NSArray* result){
        NSError *error;
        completion([self initWithDictionary:result[0] error:&error]);
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

-(AFHTTPRequestOperationManager*)DELETE:(void (^)(BaseEntity *))completion{
    return [[Request request] putWithAction:[NSString stringWithFormat:@"%@/%@", [[self class] baseEntityURL], _idS] parameters:nil success:^(NSArray* result){
        completion(self);
    }];
}

#pragma mark - Synchronous methods

-(instancetype)getForIdSynchronously:(NSString *)idS{
    NSError *error = nil;
    return [[[self class] alloc]initWithDictionary:[Request getSynchronouslyWithAction:[NSString stringWithFormat:@"%@/%@", [[self class] baseEntityURL], idS] andParams:nil][0] error:&error] ;
}

+(NSArray*)getManySynchronously:(NSDictionary *)dictionary{
    NSArray *baseEntityDictionaryArray = [Request getSynchronouslyWithAction:[NSString stringWithFormat:@"%@", [[self class] baseEntityURL]] andParams:dictionary];
    NSArray *baseEntityArray = [[self class] arrayOfModelsFromDictionaries:baseEntityDictionaryArray[0]];
    return baseEntityArray;
}

-(instancetype)createSynchronously{
    NSString *jsonString = [self toJSONString];
    [Request postSynchronouslyWithAction:[NSString stringWithFormat:@"%@", [[self class] baseEntityURL]] andParams:@{@"obj":jsonString}];
    return self;
}

-(instancetype)updateSynchronously{
    NSString *jsonString = [self toJSONString];
    [Request putSynchronouslyWithAction:[NSString stringWithFormat:@"%@", [[self class] baseEntityURL]] andParams:@{@"obj":jsonString}];
    return self;
}

-(instancetype)deleteSynchronously{
    [Request deleteSynchronouslyWithAction:[NSString stringWithFormat:@"%@/%@", [[self class] baseEntityURL], _idS]];
    return self;
}



@end
