
#import <UIKit/UIKit.h>
#import "BBDotActivityIndicatorView.h"
#import "BBDotActivityIndicatorParms.h"

FOUNDATION_EXPORT const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight;

@interface BBMessagesTypingIndicatorFooterView : UICollectionReusableView

@property (nonatomic, strong) IBOutlet BBDotActivityIndicatorView *dotActivityIndicatorView;

+ (UINib *)nib;
+ (NSString *)footerReuseIdentifier;

- (void)configureWithEllipsisColor:(UIColor *)ellipsisColor
                messageBubbleColor:(UIColor *)messageBubbleColor
               shouldDisplayOnLeft:(BOOL)shouldDisplayOnLeft
                 forCollectionView:(UICollectionView *)collectionView;

@end
