//
//  RatingViewController.m
//  JSQMessages
//
//  Created by BabylonHealth on 01/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "RatingView.h"
#import "JSQMessagesViewController.h"
@interface RatingView ()

@property (nonatomic, assign) NSInteger numberOfButtons;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, assign) CGFloat maxWidth;

@end

@implementation RatingView

-(void)setRating:(NSInteger)rating {
    NSInteger numOfButtons = 5;
    if(rating < 1 && rating > numOfButtons) {
        return;
    }
    for(NSInteger i = 1; i <= numOfButtons; i++) {
        
        UIButton *button = [self viewWithTag:i];
        
        if (button) {
            button.selected = (i <= rating);
        }
        
        if(i == rating) {
            // explode button
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                button.transform = CGAffineTransformMakeScale(1.5, 1.5);
            } completion:^(BOOL finished) {
                // implode button
                [UIView animateWithDuration:0.2 animations:^{
                    button.transform = CGAffineTransformIdentity;
                }];
            }];
        }
    }
}

#pragma mark - ib actions

-(IBAction)buttonPressed:(UIButton *)button {
    
    NSInteger rating = button.tag;
    NSLog(@"buttonPressed rating %li", (long)button.tag);
    
    if(rating == NSNotFound) {
        return;
    }
    
    [self setRating:rating];
    
    if([self.delegate respondsToSelector:@selector(ratingView:selectedRating:)]) {
        [self.delegate ratingView:self selectedRating:rating];
    }
}

#pragma mark - JSQMessageMediaData Delegate

/**
 *  @return An initialized `UIView` object that represents the data for this media object.
 *
 *  @discussion You may return `nil` from this method while the media data is being downloaded.
 */
- (UIView *)mediaView {
    return self;
}

/**
 *  @return The frame size for the mediaView when displayed in a `JSQMessagesCollectionViewCell`.
 *
 *  @discussion You should return an appropriate size value to be set for the mediaView's frame
 *  based on the contents of the view, and the frame and layout of the `JSQMessagesCollectionViewCell`
 *  in which mediaView will be displayed.
 *
 *  @warning You must return a size with non-zero, positive width and height values.
 */
- (CGSize)mediaViewDisplaySize {
    return CGSizeMake(20, 20);
}

/**
 *  @return A placeholder media view to be displayed if mediaView is not yet available, or `nil`.
 *  For example, if mediaView will be constructed based on media data that must be downloaded,
 *  this placeholder view will be used until mediaView is not `nil`.
 *
 *  @discussion If you do not need support for a placeholder view, then you may simply return the
 *  same value here as mediaView. Otherwise, consider using `JSQMessagesMediaPlaceholderView`.
 *
 *  @warning You must not return `nil` from this method.
 *
 *  @see JSQMessagesMediaPlaceholderView.
 */
- (UIView *)mediaPlaceholderView {
    return [UIView new];
}

/**
 *  @return An integer that can be used as a table address in a hash table structure.
 *
 *  @discussion This value must be unique for each media item with distinct contents.
 *  This value is used to cache layout information in the collection view.
 */
- (NSUInteger)mediaHash {
    return random()*3;
}

@end