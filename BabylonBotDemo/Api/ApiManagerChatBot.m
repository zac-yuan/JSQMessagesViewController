
#import "ApiManagerChatBot.h"
#import "BBConstants.h"
#import "AppDelegate.h"

typedef enum {apiRestGet, apiRestPost, apiRestPut, apiRestDelete} ApiRestEndPoint;

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
    _sharedConfiguration.userID = kChatBotApiUserId;
    _sharedConfiguration.authKey = kChatBotApiToken;
    _sharedConfiguration.speakerID = _sharedConfiguration.userID;
    _sharedConfiguration.targetID = @"babybot";

    return _sharedConfiguration;
}

#pragma mark - Get Methods
- (void)getTalkChat:(NSString *)query
            success:(void (^)(AFHTTPRequestOperation *operation, id response))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self.manager GET:[self apiRestBuilderUrl:@"talk" withType:apiRestGet]
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
    
    [self.manager GET:[self apiRestBuilderUrl:@"conversations" withType:apiRestGet]
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
    
    [self.manager GET:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@", self.conversationID] withType:apiRestGet]
           parameters:@{@"auth_key":self.authKey,
                        @"user_id":self.userID}
              success:^(AFHTTPRequestOperation *operation, id response) {
                  success(operation, response);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure(operation, error);
        
                  NSLog(@"Operation: %@\nError: %@", operation, error);
        
    }];
    
}

- (void)getConversationStatement:(NSString *)chatStatment withConversationId:(NSString *)chatId
                          sucess:(void (^)(AFHTTPRequestOperation *operation, id response))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self.manager GET:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@", chatId, chatStatment] withType:apiRestGet]
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
    
    [self.manager POST:[self apiRestBuilderUrl:@"conversation/text" withType:apiRestPost]
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
    
    [self.manager POST:[self apiRestBuilderUrl:@"conversation/image" withType:apiRestPost]
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
    
    [self.manager POST:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@", self.conversationID, self.statementID] withType:apiRestPost]
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

- (void)postConversationRating:(NSInteger)rating
                       success:(void (^)(AFHTTPRequestOperation *, id))success
                       failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager POST:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/element", self.conversationID] withType:apiRestPost]
            parameters:@{@"input":@{ @"value":@(rating),
                                     @"source":@{ @"source_type" : @"star_rating",
                                                  @"source_id" : [NSNull null] },
                                     @"speaker":@{ @"type" : @"user",
                                                   @"id" : self.speakerID }},
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

- (void)postConversationOption:(NSDictionary *)input withConversationId:(NSString *)conversationId
                       success:(void (^)(AFHTTPRequestOperation *, id))success
                       failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager POST:[self apiRestBuilderUrl:[NSString stringWithFormat:@"/conversation/%@/statement/option_select", conversationId] withType:apiRestPost]
            parameters:@{@"statement":@{@"value":input},
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

//ASK
- (void)post {
    
}

#pragma mark - Put Methods
- (void)putConversationText:(NSString *)input withConversationId:(NSString *)conversationId andStatementId:(NSString *)statementId
                  success:(void (^)(AFHTTPRequestOperation *, id))success
                  failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager PUT:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@/text", conversationId, statementId] withType:apiRestPut]
           parameters:@{@"statement":@{@"value":input},
                        @"auth_key":self.authKey,
                        @"user_id":self.userID}
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  success(operation, responseObject);
              } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                  failure(operation, error);
    }];
    
}

- (void)putConversationOption:(NSDictionary *)input withConversationId:(NSString *)conversationId
                      success:(void (^)(AFHTTPRequestOperation *, id))success
                      failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager PUT:[self apiRestBuilderUrl:[NSString stringWithFormat:@"/conversation/%@/statement/option_select", conversationId] withType:apiRestPost]
            parameters:@{@"statement":@{@"value":input},
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

#pragma mark - Delete Methods
- (void)deleteConversation:(NSString *)conversationId
                   success:(void (^)(AFHTTPRequestOperation *, id))success
                   failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    [self.manager DELETE:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@", conversationId] withType:apiRestDelete]
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
    
    [self.manager DELETE:[self apiRestBuilderUrl:[NSString stringWithFormat:@"conversation/%@/statement/%@", conversationId, statementId] withType:apiRestDelete]
              parameters:@{@"auth_key":self.authKey,
                           @"user_id":self.userID}
                 success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  success(operation, responseObject);
              } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                  failure(operation, error);
    }];
    
}

#pragma mark - Api Utils
- (NSString *)apiRestBuilderUrl:(NSString *)url withType:(ApiRestEndPoint)methodType {
    switch (methodType) {
        case apiRestGet:
            return [NSString stringWithFormat:@"%@/%@", kChatBotApiUrlBase, url];
        case apiRestPost:
            return [NSString stringWithFormat:@"%@/%@?auth_key=%@&user_id=%@&target_id=%@&speaker_id=%@", kChatBotApiUrlBase, url, self.authKey, self.userID, self.targetID, self.speakerID];
        case apiRestPut:
            return [NSString stringWithFormat:@"%@/%@?auth_key=%@&user_id=%@&target_id=%@&speaker_id=%@", kChatBotApiUrlBase, url, self.authKey, self.userID, self.targetID, self.speakerID];
        case apiRestDelete:
            return [NSString stringWithFormat:@"%@/%@?auth_key=%@&user_id=%@&target_id=%@&speaker_id=%@", kChatBotApiUrlBase, url, self.authKey, self.userID, self.targetID, self.speakerID];
        default:
            return [NSString stringWithFormat:@"%@/%@", kChatBotApiUrlBase, url];
    }
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
