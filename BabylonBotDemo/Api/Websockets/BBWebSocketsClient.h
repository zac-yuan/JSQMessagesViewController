
#import <Foundation/Foundation.h>
#import "BBWebSocketsChannel.h"

@class BBWebSocketsClient;

@protocol BBWebSocketsClientDelegate <NSObject>

- (void)pubNubClient:(BBWebSocketsClient *)client messages:(NSArray*)messages receivedDate:(NSDate *)receivedDate;
- (void)pubNubClient:(BBWebSocketsClient *)client presenceEvents:(NSArray *)presenceEvents;
- (void)pubNubClient:(BBWebSocketsClient *)client state:(BBWebSocketsChannelState)state;

@end

@interface BBWebSocketsClient : NSObject <BBWebSocketsChannelDelegate>

- (instancetype)initWithChannel:(NSString *)channel;

- (void)connectWithCompletion:(void (^)())completion;
- (void)disconnectWithCompletion:(void (^)())completion;

@property (nonatomic, readonly) BBWebSocketsChannel *channel;
@property (nonatomic, weak) id<BBWebSocketsClientDelegate> delegate;
@property (nonatomic, copy) NSDictionary *userInfo;

@end