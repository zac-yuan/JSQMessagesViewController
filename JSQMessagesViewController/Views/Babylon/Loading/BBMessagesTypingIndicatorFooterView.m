
#import "BBMessagesTypingIndicatorFooterView.h"
#import "JSQMessagesBubbleImageFactory.h"
#import "UIColor+JSQMessages.h"

const CGFloat kBBMessagesTypingIndicatorFooterViewHeight = 46.0f;

@interface BBMessagesTypingIndicatorFooterView ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewRightHorizontalConstraint;

@end

@implementation BBMessagesTypingIndicatorFooterView

#pragma mark - Class methods

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([BBMessagesTypingIndicatorFooterView class])
                          bundle:[NSBundle bundleForClass:[BBMessagesTypingIndicatorFooterView class]]];
}

+ (NSString *)footerReuseIdentifier {
    return NSStringFromClass([BBMessagesTypingIndicatorFooterView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.typingIndicatorView.contentMode = UIViewContentModeScaleAspectFit;
    self.dotActivityIndicatorView.dotParms = [self loadDotActivityIndicatorParms];
}

- (BBDotActivityIndicatorParms *)loadDotActivityIndicatorParms {
    BBDotActivityIndicatorParms *dotParms = [BBDotActivityIndicatorParms new];
    dotParms.activityViewWidth = self.dotActivityIndicatorView.frame.size.width;
    dotParms.activityViewHeight = self.dotActivityIndicatorView.frame.size.height;
    dotParms.numberOfCircles = 3;
    dotParms.internalSpacing = 3.5;
    dotParms.animationDelay = 0.2;
    dotParms.animationDuration = 0.6;
    dotParms.animationFromValue = 0.5;
    dotParms.defaultColor = [UIColor jsq_messageBubbleBlueColor];
    dotParms.isDataValidationEnabled = YES;
    return dotParms;
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.bubbleImageView.backgroundColor = backgroundColor;
}

#pragma mark - Typing indicator

- (void)configureWithEllipsisColor:(UIColor *)ellipsisColor
                messageBubbleColor:(UIColor *)messageBubbleColor
               shouldDisplayOnLeft:(BOOL)shouldDisplayOnLeft
                 forCollectionView:(UICollectionView *)collectionView {
    
    NSParameterAssert(ellipsisColor != nil);
    NSParameterAssert(messageBubbleColor != nil);
    NSParameterAssert(collectionView != nil);
    
    CGFloat bubbleMarginMinimumSpacing = 6.0f;
    CGFloat indicatorMarginMinimumSpacing = 24.0f;

    self.dotActivityIndicatorView.dotParms.defaultColor = ellipsisColor;

    JSQMessagesBubbleImageFactory *bubbleImageFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    if (shouldDisplayOnLeft) {
        
        self.bubbleImageView.image = [bubbleImageFactory incomingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
        
        CGFloat collectionViewWidth = CGRectGetWidth(collectionView.frame);
        CGFloat bubbleWidth = CGRectGetWidth(self.bubbleImageView.frame);
        CGFloat indicatorWidth = CGRectGetWidth(self.typingIndicatorView.frame);
        
        CGFloat bubbleMarginMaximumSpacing = collectionViewWidth - bubbleWidth - bubbleMarginMinimumSpacing;
        CGFloat indicatorMarginMaximumSpacing = collectionViewWidth - indicatorWidth - indicatorMarginMinimumSpacing;
        
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMaximumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMaximumSpacing;
        
    } else {
        
        self.bubbleImageView.image = [bubbleImageFactory outgoingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
        
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMinimumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMinimumSpacing;
        
    }
    
    [self setNeedsUpdateConstraints];
    
    [self.dotActivityIndicatorView stopAnimating];
    self.typingIndicatorView = self.dotActivityIndicatorView;
    [self.dotActivityIndicatorView startAnimating];
    
}


@end
