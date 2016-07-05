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

-(instancetype)initWithNumberOfButtons:(NSInteger)numberOfButtons
                              maxWidth:(CGFloat)maxWidth
                         initialRating:(NSInteger)rating {
    
    self = [super init];
    
    
    [self setup];
    
    
    if(self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSAssert(numberOfButtons > 1, @"numberOfButtons must be > 1");
        NSAssert(maxWidth > 0, @"maxWidth must be > 0");
        NSAssert(rating > 0 && rating <= numberOfButtons, @"rating must be > 0 and <= numberOfButtons");
        
        self.numberOfButtons = numberOfButtons;
        self.maxWidth = maxWidth;
        
        NSArray *buttons = [self createButtons:numberOfButtons];
        for(NSInteger i = 0; i < buttons.count; i++) {
            UIButton *button = buttons[i];
            button.selected = (i <= (rating - 1));
        }
        self.buttons = buttons;
        
        //[self setupUiFromButtons:buttons maxWidth:maxWidth];
    }
    return self;
}

-(void)setup {
    
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]] ) {
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}

-(NSArray *)createButtons:(NSInteger)numberOfButtons {
    NSMutableArray *buttons = [NSMutableArray new];
    for(NSInteger i = 0; i < numberOfButtons; i++) {
        [buttons addObject:[self createButton]];
    }
    return [NSArray arrayWithArray:buttons];
}

-(UIButton *)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"star-rating-unselected"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"star-rating-selected"] forState:UIControlStateSelected];
    if([self respondsToSelector:@selector(buttonPressed:)]) {
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

-(void)setRating:(NSInteger)rating {
    NSInteger numOfButtons = 5;
    if(rating < 0 && rating > numOfButtons) {
        return;
    }
    for(NSInteger i = 0; i < numOfButtons; i++) {
        UIButton *button = self.buttons[i];
        button.selected = (i <= rating);
        
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
    
    NSInteger rating = [self.buttons indexOfObject:button];
    NSLog(@"index %li tag %li", (long)rating, (long)button.tag);
    
    if(rating == NSNotFound) {
        return;
    }
    [self setRating:rating];
    
    if([self.delegate respondsToSelector:@selector(ratingView:selectedRating:)]) {
        [self.delegate ratingView:self selectedRating:(rating + 1)];
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