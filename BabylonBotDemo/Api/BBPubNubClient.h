
#import <Foundation/Foundation.h>
#import <PubNub/PubNub.h>

@protocol BBPubNubClientDelegate <NSObject>
- (void)pubNubClient:(PubNub *)client didReceiveMessage:(PNMessageResult *)message;
- (void)pubNubClient:(PubNub *)client didReceiveStatus:(PNSubscribeStatus *)status;
@end

@interface BBPubNubClient : NSObject <PNObjectEventListener>
- (void)subscribeToChannel:(NSString *)channelName;
- (void)pingPubNubService:(void (^)(PNErrorStatus *status, PNTimeResult *result))completionHandler;
@property (nonatomic, weak) id<BBPubNubClientDelegate> pubNubClientDelegate;
@property (nonatomic) PubNub *pubNubClient;
@end
