
#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "Request.h"
#import <AFHTTPRequestOperationManager.h>

@class Request;
@interface RestEntity  : JSONModel

@property(nonatomic, strong) NSString *idS;

/**
 * Gets the entity from the server with url {entity_name}/{id}.
 * @param idS - the id of the entity to get
 * @param completion - the block called at the end of the request
 * @return AFHTTPRequestOperationManager with all the info on the request (url, etc)
 **/
-(AFHTTPRequestOperationManager*)getForId:(NSString*)idS completion:(void (^)(BaseEntity *))completion;

/**
 * Gets a group of entities from the server with url {entity_name}.
 * @param completion - the block called at the end of the request
 * @return AFHTTPRequestOperationManager with all the info on the request (url, etc)
 **/
+(AFHTTPRequestOperationManager*)getMany:(NSDictionary *)dictionary completion:(void (^)(NSArray *))completion;

/**
 * Creates the entity on the server with url {entity_name}.
 * @param completion - the block called at the end of the request
 * @return AFHTTPRequestOperationManager with all the info on the request (url, etc)
 **/
-(AFHTTPRequestOperationManager*)create:(void (^)(BaseEntity *))completion;

/**
 * Updates the entity on the server with url {entity_name}.
 * @param completion - the block called at the end of the request
 * @return AFHTTPRequestOperationManager with all the info on the request (url, etc)
 **/
-(AFHTTPRequestOperationManager*)update:(void (^)(BaseEntity *))completion;

/**
 * Deletes the entity on the server with url {entity_name}.
 * @param completion - the block called at the end of the request
 * @return AFHTTPRequestOperationManager with all the info on the request (url, etc)
 **/
-(AFHTTPRequestOperationManager*)DELETE:(void (^)(BaseEntity *))completion;

-(instancetype)getForIdSynchronously:(NSString*)idS;

-(instancetype)createSynchronously;

-(instancetype)updateSynchronously;

-(instancetype)deleteSynchronously;


+(NSArray*)getManySynchronously:(NSDictionary*)dictionary;

+(NSString*)baseEntityURL;

+(void)setPrefix:(NSString*)p;
+(NSString*)getPrefix;
@end
