
#import <Foundation/Foundation.h>

@class BBWebSocketsChannel;

typedef NS_ENUM(NSUInteger, BBWebSocketsChannelState) {
    BBWebSocketsChannelStateConnected,
    BBWebSocketsChannelStateTransientFailure,
    BBWebSocketsChannelStateDisconnected
};

@protocol BBWebSocketsChannelDelegate <NSObject>

- (void)webSocketsChannel:(BBWebSocketsChannel *)channel messages:(NSArray *)messages receivedDate:(NSDate *)receivedDate;
- (void)webSocketsChannel:(BBWebSocketsChannel *)channel state:(BBWebSocketsChannelState)state;

@end

@interface BBWebSocketsChannel : NSObject <NSURLSessionDelegate>

- (instancetype)initWithName:(NSString *)name heartbeat:(BOOL)heartbeat;

- (void)subscribeWithUserInfo:(NSDictionary *)userInfo completion:(void (^)())completion;
- (void)unsubscribeWithCompletion:(void (^)())completion;
- (void)publishMessage:(NSDictionary *)message;
- (void)hereNowWithCompletion:(void (^)(NSArray *users))completion;
- (void)historyWithStartTime:(long long)startTime endTime:(long long)endTime limit:(NSInteger)limit completion:(void (^)(long long start, long long end, NSArray *messages))completion;

@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) BBWebSocketsChannelState state;
@property (nonatomic, weak) id<BBWebSocketsChannelDelegate> delegate;

@end