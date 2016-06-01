
#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>

@protocol BBPubNubClientDelegate <NSObject>
- (void)pubNubClient:(PubNub *)client didReceiveMessage:(PNMessageResult *)message;
- (void)pubNubClient:(PubNub *)client didReceiveStatus:(PNSubscribeStatus *)status;
@end

@interface BBPubNubClient : NSObject <PNObjectEventListener>
+ (instancetype)shared;
- (void)subscribeToChannel:(NSString *)channelName completionHandler:(void(^)(PNAcknowledgmentStatus *status))completionHandler;
- (void)pingPubNubService:(void (^)(PNErrorStatus *status, PNTimeResult *result))completionHandler;
- (void)saveDeviceToken:(NSData *)deviceToken;
@property (nonatomic, weak) id<BBPubNubClientDelegate> pubNubClientDelegate;
@property (nonatomic, strong) PubNub *pubNubClient;
@property (nonatomic, strong) NSString *subscribedChannel;
@end
