
#import <UIKit/UIKit.h>
#import <PubNub/PubNub.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, PNObjectEventListener>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) PubNub *pubNubClient;

@end

