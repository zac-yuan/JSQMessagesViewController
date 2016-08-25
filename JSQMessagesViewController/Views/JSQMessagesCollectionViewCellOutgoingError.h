
#import "JSQMessagesCollectionViewCell.h"

/**
 *  A `JSQMessagesCollectionViewCellOutgoingError` object is a concrete instance
 *  of `JSQMessagesCollectionViewCell` that represents an outgoing message data item.
 */

@interface JSQMessagesCollectionViewCellOutgoingError : JSQMessagesCollectionViewCell <JSQMessagesCollectionViewErrorCell>

@property (weak, nonatomic) IBOutlet UIButton *retryButton;

@end
