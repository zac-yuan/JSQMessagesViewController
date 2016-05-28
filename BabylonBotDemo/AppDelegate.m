
#import "AppDelegate.h"
#import "BBConstants.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:kPubNubPublishKey
                                                                         subscribeKey:kPubNubSubscribeKey];
    
    _pubNubClient = [PubNub clientWithConfiguration:configuration];
    [_pubNubClient addListener:self];
    [self pingPubNubService];
    
    return YES;
}

- (void)pingPubNubService {
    [self.pubNubClient timeWithCompletion:^(PNTimeResult *result, PNErrorStatus *status) {
        
        // Check whether request successfully completed or not.
        if (!status.isError) {
            
            // Handle downloaded server time token using: result.data.timetoken
        }
        // Request processing failed.
        else {
            
            // Handle tmie token download error. Check 'category' property to find
            // out possible issue because of which request did fail.
            //
            // Request can be resent using: [status retry];
        }
    }];
}


- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    // Handle new message stored in message.data.message
    if (message.data.actualChannel) {
        
        // Message has been received on channel group stored in
        // message.data.subscribedChannel
    }
    else {
        
        // Message has been received on channel stored in
        // message.data.subscribedChannel
    }
    NSLog(@"Received message: %@ on channel %@ at %@", message.data.message,
          message.data.subscribedChannel, message.data.timetoken);
}

- (void)client:(PubNub *)client didReceiveStatus:(PNSubscribeStatus *)status {
    
    if (status.category == PNUnexpectedDisconnectCategory) {
        // This event happens when radio / connectivity is lost
    }
    
    else if (status.category == PNConnectedCategory) {
        
        // Connect event. You can do stuff like publish, and know you'll get it.
        // Or just use the connected event to confirm you are subscribed for
        // UI / internal notifications, etc
        
        [self.pubNubClient publish: @"Hello from the PubNub Objective-C SDK" toChannel:@"1077"
              withCompletion:^(PNPublishStatus *status) {
                  
                  // Check whether request successfully completed or not.
                  if (!status.isError) {
                      
                      // Message successfully published to specified channel.
                  }
                  // Request processing failed.
                  else {
                      
                      // Handle message publish error. Check 'category' property to find out possible issue
                      // because of which request did fail.
                      //
                      // Request can be resent using: [status retry];
                  }
              }];
    }
    else if (status.category == PNReconnectedCategory) {
        
        // Happens as part of our regular operation. This event happens when
        // radio / connectivity is lost, then regained.
    }
    else if (status.category == PNDecryptionErrorCategory) {
        
        // Handle messsage decryption error. Probably client configured to
        // encrypt messages and on live data feed it received plain text.
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
