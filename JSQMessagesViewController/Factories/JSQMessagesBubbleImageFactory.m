//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"
#import "UIColor+JSQMessages.h"


@interface JSQMessagesBubbleImageFactory ()

@property (strong, nonatomic, readonly) UIImage *bubbleImage;
@property (assign, nonatomic, readonly) UIEdgeInsets capInsets;

@end



@implementation JSQMessagesBubbleImageFactory

#pragma mark - Initialization

- (instancetype)initWithBubbleImage:(UIImage *)bubbleImage capInsets:(UIEdgeInsets)capInsets
{
	NSParameterAssert(bubbleImage != nil);
    
	self = [super init];
	if (self) {
		_bubbleImage = bubbleImage;
        
        if (UIEdgeInsetsEqualToEdgeInsets(capInsets, UIEdgeInsetsZero)) {
            _capInsets = [self jsq_centerPointEdgeInsetsForImageSize:bubbleImage.size];
        }
        else {
            _capInsets = capInsets;
        }
	}
	return self;
}

- (instancetype)init
{
    return [self initWithBubbleImage:[UIImage jsq_bubbleCompactImage] capInsets:UIEdgeInsetsZero];
}

#pragma mark - Public

- (JSQMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color
{
    return [self jsq_messagesBubbleImageWithColor:color flippedForIncoming:NO];
}

- (JSQMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color
{
    return [self jsq_messagesBubbleImageWithColor:color flippedForIncoming:YES];
}

#pragma mark - Private

- (UIEdgeInsets)jsq_centerPointEdgeInsetsForImageSize:(CGSize)bubbleImageSize
{
    // make image stretchable from center point
    CGPoint center = CGPointMake(bubbleImageSize.width / 2.0f, bubbleImageSize.height / 2.0f);
    return UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
}

- (JSQMessagesBubbleImage *)jsq_messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming
{
    NSParameterAssert(color != nil);
    
    if (![color isEqual:[UIColor whiteColor]]) {
        return [self jsq_messagesDefaultBubble:color flippedForIncoming:flippedForIncoming];
    } else {
        return [self jsq_messagesBorderBubble:color flippedForIncoming:flippedForIncoming];
    }
    
}

- (JSQMessagesBubbleImage *)jsq_messagesDefaultBubble:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming {
    
    UIImage *normalBubble = [self.bubbleImage jsq_imageMaskedWithColor:color];
    UIImage *highlightedBubble = [self.bubbleImage jsq_imageMaskedWithColor:[color jsq_colorByDarkeningColorWithValue:0.12f]];
    
    if (flippedForIncoming) {
        normalBubble = [self jsq_horizontallyFlippedImageFromImage:normalBubble];
        highlightedBubble = [self jsq_horizontallyFlippedImageFromImage:highlightedBubble];
    }
    
    normalBubble = [self jsq_stretchableImageFromImage:normalBubble withCapInsets:self.capInsets];
    highlightedBubble = [self jsq_stretchableImageFromImage:highlightedBubble withCapInsets:self.capInsets];
    
    return [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:normalBubble highlightedImage:highlightedBubble];

}

- (JSQMessagesBubbleImage *)jsq_messagesBorderBubble:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming {
    
    UIImage *image = [UIImage jsq_bubbleRegularImage];
    UIImage *strokedImage = [UIImage jsq_bubbleRegularStrokedImage];
    UIImage *coloredImage;
    UIImage *coloredStrokedImage;
    
    coloredImage = [image jsq_imageMaskedWithColor:color];
    coloredStrokedImage = [strokedImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
    
    UIImage *normalBubble = [self addImage:coloredImage withImage:coloredStrokedImage];
    
    color = [color jsq_colorByDarkeningColorWithValue:0.12f];
    coloredImage = [image jsq_imageMaskedWithColor:color];
    coloredStrokedImage = [strokedImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
    
    UIImage *highlightedBubble = [self addImage:coloredImage withImage:coloredStrokedImage];
    
    if (flippedForIncoming) {
        normalBubble = [self jsq_horizontallyFlippedImageFromImage:normalBubble];
        highlightedBubble = [self jsq_horizontallyFlippedImageFromImage:highlightedBubble];
    }
    
    normalBubble = [self jsq_stretchableImageFromImage:normalBubble withCapInsets:self.capInsets];
    highlightedBubble = [self jsq_stretchableImageFromImage:highlightedBubble withCapInsets:self.capInsets];
    
    return [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:normalBubble highlightedImage:highlightedBubble];
}

- (UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2
{
    UIImage *result;
    
    UIGraphicsBeginImageContext(image1.size);
    {
        [image1 drawAtPoint:CGPointZero];
        [image2 drawAtPoint:CGPointZero];
        result = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return result;
}

- (UIImage *)jsq_horizontallyFlippedImageFromImage:(UIImage *)image
{
    return [UIImage imageWithCGImage:image.CGImage
                               scale:image.scale
                         orientation:UIImageOrientationUpMirrored];
}

- (UIImage *)jsq_stretchableImageFromImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets
{
    return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

@end
