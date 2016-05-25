
#import "ApiManagerChatBot.h"
#import "BBWebSocketsClient.h"

typedef enum {apiRestGet, apiRestPost, apiRestPut, apiRestDelete} ApiRestEndPoint;

//dev-chatscript.babylontesting.co.uk/v1
//staging-chatscript.babylontesting.co.uk/v1
NSString *const chatBotApiUrlBase = @"http://dev-chatscript.babylontesting.co.uk/v1";

@implementation ApiManagerChatBot

+ (instancetype)sharedConfiguration {
    static ApiManagerChatBot *_sharedConfiguration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfiguration = [[self alloc] init];
        _sharedConfiguration.manager = [AFHTTPRequestOperationManager manager];
        [_sharedConfiguration.manager.requestSerializer setTimeoutInterval:8.0f];
        [_sharedConfiguration.manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [_sharedConfiguration.manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [_sharedConfiguration.manager.reachabilityManager startMonitoring];
    });
    
    //HARDCODE: DEMO ONLY
    _sharedConfiguration.userID = @"1077";
    _sharedConfiguration.authKey = @"73e40106b7bef08ae9a1888e35882a4b";
    _sharedConfiguration.speakerID = @"babybot";
    _sharedConfiguration.targetID = _sharedConfiguration.userID;
    
    //FIXME: MOVE IT
    [_sharedConfiguration initWebSocketChannel:_sharedConfiguration.userID];
    
    return _sharedConfiguration;
}

#pragma mark - Get Methods
- (void)getTalkChat:(NSString *)query
            success:(void (^)(AFHTTPRequestOperation *operation, id response))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self.manager GET:[self apiRestBuilderUrl:@"talk"]
           parameters:@{@"query":query,
                        @"auth_key":self.authKey,
                        @"user_id":self.userID}
              success:^(AFHTTPRequestOperation *operation, id response) {
                  success(operation, response);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure(operation, error);
        
                  NSLog(@"Operation: %@\nError: %@", operation, error);
        
    }];
    
}

- (void)getConversations:(void (^)(AFHTTPRequestOperation *operation, id response))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self.manager GET:[self apiRestBuilderUrl:@"conversations"]
           parameters:@{@"auth_key":self.authKey,
                        @"user_id":self.userID}
              success:^(AFHTTPRequestOperation *operation, id response) {
                  success(operation, response);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure(operation, error);
        
                  NSLog(@"Operation: %@\nError: %@", operation, error);
        
    }];
    
}

- (void)getConversationHistory:(void (^)(AFHTTPRequestOperation *operation, id response))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self.manager GET:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@", self.conversationID]]
           parameters:@{@"auth_key":self.authKey,
                        @"user_id":self.userID}
              success:^(AFHTTPRequestOperation *operation, id response) {
                  success(operation, response);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure(operation, error);
        
                  NSLog(@"Operation: %@\nError: %@", operation, error);
        
    }];
    
}

- (void)getConversationStatement:(void (^)(AFHTTPRequestOperation *operation, id response))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self.manager GET:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@", self.conversationID, self.statementID]]
           parameters:@{@"auth_key":self.authKey,
                        @"user_id":self.userID}
              success:^(AFHTTPRequestOperation *operation, id response) {
                  success(operation, response);
              
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure(operation, error);

                  NSLog(@"Operation: %@\nError: %@", operation, error);

    }];
    
}

#pragma mark - Post Methods
- (void)postConversationText:(NSString *)input
                     success:(void (^)(AFHTTPRequestOperation *operation, id response))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self.manager POST:[self apiRestBuilderUrl:@"conversation/text"]
            parameters:@{@"value":[self formatedInput:input],
                         @"auth_key":self.authKey,
                         @"user_id":self.userID,
                         @"target_id":self.targetID,
                         @"speaker_id":self.speakerID}
               success:^(AFHTTPRequestOperation *operation, id response) {
                   success(operation, response);
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   failure(operation, error);
                
                   NSLog(@"Operation: %@\nError: %@", operation, error);
    }];
    
}

- (void)postConversationImage:(UIImage *)image
                      success:(void (^)(AFHTTPRequestOperation *, id))success
                      failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager POST:[self apiRestBuilderUrl:@"conversation/image"]
            parameters:@{@"input":@{@"value":[self encodeToBase64String:image]},
                         @"auth_key":self.authKey,
                         @"user_id":self.userID,
                         @"target_id":self.targetID,
                         @"speaker_id":self.speakerID}
               success:^(AFHTTPRequestOperation *operation, id response) {
                   success(operation, response);
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   failure(operation, error);
                
                   NSLog(@"Operation: %@\nError: %@", operation, error);
                
    }];
    
}

- (void)postConversationStatmentImage:(UIImage *)image
                        withStatement:(NSString *)statementId success:(void (^)(AFHTTPRequestOperation *, id))success
                              failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager POST:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@", self.conversationID, self.statementID]]
            parameters:@{@"input":@{@"value":[self encodeToBase64String:image]},
                         @"auth_key":self.authKey,
                         @"user_id":self.userID,
                         @"target_id":self.targetID,
                         @"speaker_id":self.speakerID}
               success:^(AFHTTPRequestOperation *operation, id response) {
                   success(operation, response);
                   
                   NSLog(@"%@", response);
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   failure(operation, error);
                   
                   NSLog(@"Operation: %@\nError: %@", operation, error);
                   
    }];
    
}

#pragma mark - Put Methods
- (void)putConversationText:(NSString *)input withConversationId:(NSString *)conversationId andStatementId:(NSString *)statementId
                  success:(void (^)(AFHTTPRequestOperation *, id))success
                  failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager PUT:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@/text", conversationId, statementId]]
           parameters:@{@"statement":@{@"value":input},
                        @"auth_key":self.authKey,
                        @"user_id":self.userID}
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  success(operation, responseObject);
              } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                  failure(operation, error);
    }];
    
}

#pragma mark - Delete Methods
- (void)deleteConversation:(NSString *)conversationId
                   success:(void (^)(AFHTTPRequestOperation *, id))success
                   failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager DELETE:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@", conversationId]]
              parameters:@{@"auth_key":self.authKey,
                           @"user_id":self.userID}
                 success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                     success(operation, responseObject);
                 } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                     failure(operation, error);
    }];
    
}

- (void)deleteConversation:(NSString *)conversationId withStatement:(NSString *)statementId
                   success:(void (^)(AFHTTPRequestOperation *, id))success
                   failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager DELETE:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@", conversationId, statementId]]
              parameters:@{@"auth_key":self.authKey,
                           @"user_id":self.userID}
                 success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  success(operation, responseObject);
              } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                  failure(operation, error);
    }];
    
}

#pragma mark - WebSocket
- (void)initWebSocketChannel:(NSString *)channelName {
    
    BBWebSocketsClient *socketClient = [[BBWebSocketsClient alloc] initWithChannel:channelName];
    [socketClient connectWithCompletion:^{
        NSLog(@"websocket connect");
    }];
    
}

#pragma mark - Api Utils
- (NSString *)apiRestBuilderUrl:(NSString *)url {
    return [NSString stringWithFormat:@"%@/%@", chatBotApiUrlBase, url];
}

- (NSString *)formatedInput:(NSString *)input {
    return [[input stringByReplacingOccurrencesOfString:@" " withString:@"+"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImageJPEGRepresentation(image, 0.8f) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (BOOL)isConnectedToInternet {
    return [[_manager reachabilityManager] isReachable];
}


@end
