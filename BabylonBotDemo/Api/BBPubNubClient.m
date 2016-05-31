
#import "BBPubNubClient.h"
#import "BBConstants.h"

@implementation BBPubNubClient

+ (instancetype)shared {
    static BBPubNubClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance initWebSockets];
    });
    
    return _sharedInstance;
}

- (void)initWebSockets {
    
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:kPubNubPublishKey
                                                                     subscribeKey:kPubNubSubscribeKey];
    _pubNubClient = [PubNub clientWithConfiguration:configuration];
    [_pubNubClient addListener:self];
    
}

- (void)pingPubNubService:(void (^)(PNErrorStatus *status, PNTimeResult *result))completionHandler {
    [self.pubNubClient timeWithCompletion:^(PNTimeResult *result, PNErrorStatus *status) {
        if (!status.isError) {
            completionHandler(status, result);
        } else {
            
            //TODO:
            // Handle tmie token download error. Check 'category' property to find
            // out possible issue because of which request did fail.

            [status retry];
            
        }
    }];
}

- (void)subscribeToChannel:(NSString *)channelName completionHandler:(void(^)(PNAcknowledgmentStatus *status))completionHandler {
    [self setSubscribedChannel:channelName];
    [self.pubNubClient subscribeToChannels:@[channelName] withPresence:NO];
    [self addPushNotificationForChannel:channelName completionHandler:^(PNAcknowledgmentStatus *status) {
        completionHandler(status);
    }];
}

- (void)addPushNotificationForChannel:(NSString *)channelName
                    completionHandler:(void(^)(PNAcknowledgmentStatus *status))completionHandler {
    [self.pubNubClient addPushNotificationsOnChannels:@[channelName]
                                  withDevicePushToken:self.deviceToken
                                        andCompletion:^(PNAcknowledgmentStatus * _Nonnull status) {
                                            completionHandler(status);
    }];
}

- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    if ([message.data.subscribedChannel isEqualToString:self.subscribedChannel]) {
        if ([self.pubNubClientDelegate respondsToSelector:@selector(pubNubClient:didReceiveMessage:)]) {
            [self.pubNubClientDelegate pubNubClient:client didReceiveMessage:message];
        }
    }
    
    // Handle new message stored in message.data.message
    if (message.data.actualChannel) {
        
        // Message has been received on channel group stored in
        // message.data.subscribedChannel
        
    } else {
        
        // Message has been received on channel stored in
        // message.data.subscribedChannel
    }
    
    NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
          message.data.subscribedChannel, message.data.timetoken);
}

- (void)client:(PubNub *)client didReceiveStatus:(PNSubscribeStatus *)status {
    if ([self.pubNubClientDelegate respondsToSelector:@selector(pubNubClient:didReceiveStatus:)]) {
        [self.pubNubClientDelegate pubNubClient:client didReceiveStatus:status];
    }
    
    if (status.category == PNUnexpectedDisconnectCategory) {
        // This event happens when radio / connectivity is lost
    }
    
    else if (status.category == PNConnectedCategory) {
        
        // Connect event. You can do stuff like publish, and know you'll get it.
        // Or just use the connected event to confirm you are subscribed for
        // UI / internal notifications, etc
        
//        [self.pubNubClient publish: @"Hello from the PubNub Objective-C SDK" toChannel:@"1077"
//                    withCompletion:^(PNPublishStatus *status) {
//                        
//                        // Check whether request successfully completed or not.
//                        if (!status.isError) {
//                            
//                            // Message successfully published to specified channel.
//                        }
//                        // Request processing failed.
//                        else {
//                            
//                            // Handle message publish error. Check 'category' property to find out possible issue
//                            // because of which request did fail.
//                            //
//                            // Request can be resent using: [status retry];
//                        }
//                    }];
    
    } else if (status.category == PNReconnectedCategory) {
        
        // Happens as part of our regular operation. This event happens when
        // radio / connectivity is lost, then regained.
    
    } else if (status.category == PNDecryptionErrorCategory) {
        
        // Handle messsage decryption error. Probably client configured to
        // encrypt messages and on live data feed it received plain text.
        
    }
    
}

@end
