
#import "JSQMessagesCollectionViewCellOutgoingError.h"

@interface JSQMessagesCollectionViewCellOutgoingError ()
@property (weak, nonatomic) IBOutlet UIButton *retryButton;
@end

@implementation JSQMessagesCollectionViewCellOutgoingError

#pragma mark - Overrides

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentRight;
    self.cellBottomLabel.textAlignment = NSTextAlignmentRight;
}

@end
