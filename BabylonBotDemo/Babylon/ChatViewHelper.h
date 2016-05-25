
#import "BBChatBotDataModelTalkChat.h"
#import "JSQMessages.h"
#import "ApiManagerChatBot.h"

static NSString *kBabylonDoctorName = @"Dr. Babylon";
static NSString *kBabylonDoctorId = @"babyBot";

@interface ChatViewHelper : JSQMessagesViewController <UIActionSheetDelegate, JSQMessagesComposerTextViewPasteDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) NSMutableArray *chatMessagesArray;
@property (strong, nonatomic) JSQMessagesBubbleImage *userBubbleMsg;
@property (strong, nonatomic) JSQMessagesBubbleImage *botBubbleMsg;

- (void)customAction:(id)sender;
- (void)sendMessage:(UIButton *)button withMessageText:(NSString *)text
           senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date;
@end
