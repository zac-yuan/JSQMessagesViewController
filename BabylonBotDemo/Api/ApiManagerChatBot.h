
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ApiManagerChatBot : NSObject
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *authKey;
@property (nonatomic, strong) NSString *statementID;
@property (nonatomic, strong) NSString *conversationID;
@property (nonatomic, strong) NSString *speakerID;
@property (nonatomic, strong) NSString *targetID;

+ (instancetype)sharedConfiguration;

// Get Methods
- (void)getTalkChat:(NSString *)query
            success:(void (^)(AFHTTPRequestOperation *operation, id response))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getConversations:(void (^)(AFHTTPRequestOperation *operation, id response))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getConversationHistory:(void (^)(AFHTTPRequestOperation *operation, id response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)getConversationStatement:(NSString *)chatStatment withConversationId:(NSString *)chatId
                          sucess:(void (^)(AFHTTPRequestOperation *operation, id response))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// Post Methods
- (void)postConversationText:(NSString *)input
                     success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)postConversationImage:(UIImage *)image
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)postConversationStatmentImage:(UIImage *)image withStatement:(NSString *)statementId
                      success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)postConversationOption:(NSDictionary *)input withConversationId:(NSString *)conversationId
                       success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// Put Methods
- (void)putConversationText:(NSString *)input withConversationId:(NSString *)conversationId andStatementId:(NSString *)statementId
                    success:(void (^)(AFHTTPRequestOperation *, id))success
                    failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

- (void)putConversationOption:(NSDictionary *)input withConversationId:(NSString *)conversationId
                      success:(void (^)(AFHTTPRequestOperation *, id))success
                      failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

// Delete Methods
- (void)deleteConversation:(NSString *)conversationId
                   success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)deleteConversation:(NSString *)conversationId withStatement:(NSString *)statementId
                   success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
