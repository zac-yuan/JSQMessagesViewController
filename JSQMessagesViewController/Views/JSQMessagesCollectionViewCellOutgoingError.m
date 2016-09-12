
#import "JSQMessagesCollectionViewCellOutgoingError.h"

@implementation JSQMessagesCollectionViewCellOutgoingError

#pragma mark - Overrides

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentRight;
    self.cellBottomLabel.textAlignment = NSTextAlignmentRight;
}

- (IBAction)retryButtonAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [self.delegate messagesCollectionViewCellDidTapMessageBubble:self];
}

@end
