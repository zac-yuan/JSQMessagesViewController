
#import "BBChatBotDataModelTalkChat.h"
#import "BBChatBotDataModelV2.h"
#import "JSQMessages.h"
#import "ApiManagerChatBot.h"
#import "BBPubNubClient.h"

@import Babylon_Check;

typedef void (^ChatViewHelperSendSuccess)(void);

@interface ChatViewHelper : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, BBPubNubClientDelegate, JSQMessagesOptionsDelegate>
@property (strong, nonatomic) NSMutableArray *chatMessagesArray;
@property (strong, nonatomic) JSQMessagesBubbleImage *userBubbleMsg;
@property (strong, nonatomic) JSQMessagesBubbleImage *botBubbleMsg;
@property (nonatomic, strong) BBPubNubClient *pubNubClient;

- (void)customAction:(id)sender;
- (void)sendMessage:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date showMessage:(BOOL)showMessage success:(ChatViewHelperSendSuccess)success;
- (void)addChatMessageForUser:(JSQMessage *)message showObject:(BOOL)showObject;
- (void)addChatMessageForBot:(JSQMessage *)message showObject:(BOOL)showObject;

#pragma mark - Create buttons list
-(void)createButtonsListWithFlow:(Flow *)flow;
-(void)createButtonsListWithOutcome:(Outcome *)outcome;

#pragma mark - currentFlow
@property (nonatomic, strong) Flow *currentFlow;

@end
