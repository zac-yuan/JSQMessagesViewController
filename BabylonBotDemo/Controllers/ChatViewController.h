
#import "JSQMessages.h"
#import "ChatViewHelper.h"
@import Babylon_Check;

@interface ChatViewController : ChatViewHelper <ChatDelegate>
@property(nonnull, strong) CheckController *checkController;
@end
