
#import "BBWebSocketsClient.h"

static NSString *kPubNubPresenceSuffix = @"-pnpres";

@implementation BBWebSocketsClient {
    BBWebSocketsChannel *_channel;
    BBWebSocketsChannel *_presenceChannel;
}

- (instancetype)initWithChannel:(NSString*)channel {
    self = [super init];
    if (self) {
        _channel = [[BBWebSocketsChannel alloc] initWithName:channel heartbeat:YES];
        _channel.delegate = self;
        _presenceChannel = [[BBWebSocketsChannel alloc] initWithName:[channel stringByAppendingString:kPubNubPresenceSuffix] heartbeat:NO];
        _presenceChannel.delegate = self;
        _userInfo = @{@"name":channel};
    }
    return self;
}


- (void)connectWithCompletion:(void (^)())completion {
    [_channel subscribeWithUserInfo:_userInfo completion:^{
        [_presenceChannel subscribeWithUserInfo:_userInfo completion:^{
            completion();
        }];
    }];
}

- (void)disconnectWithCompletion:(void (^)())completion {
    [_channel unsubscribeWithCompletion:^{
        [_presenceChannel unsubscribeWithCompletion:^{
            completion();
        }];
    }];
}

- (void)webSocketsChannel:(BBWebSocketsChannel *)channel messages:(NSArray *)messages receivedDate:(NSDate*)receivedDate {
    if (self.delegate) {
        if (channel == _presenceChannel) {
            [self.delegate pubNubClient:self presenceEvents:messages];
        } else {
            [self.delegate pubNubClient:self messages:messages receivedDate:receivedDate];
        }
    }
}

- (void)webSocketsChannel:(BBWebSocketsChannel *)channel state:(BBWebSocketsChannelState)state {
    if (channel == _channel) {
        [self.delegate pubNubClient:self state:state];
    }
}

@end
