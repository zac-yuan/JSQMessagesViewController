//
//  RatingViewController.m
//  JSQMessages
//
//  Created by BabylonHealth on 01/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "RatingView.h"

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
    if(self) {
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
     
        [self setupUiFromButtons:buttons maxWidth:maxWidth];
    }
    return self;
}

-(void)setupUiFromButtons:(NSArray *)buttons maxWidth:(CGFloat)maxWidth {
    CGFloat height = maxWidth / buttons.count;
    self.bounds = CGRectMake(0, 0, maxWidth + 5, height);
    
    // Constraints: H:[Button][Button]...buttons.count
    //              V:|[Button]|
    UIButton *prevButton = nil;
    for(UIButton *button in buttons) {
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:button];
        
        if(prevButton) {
            // contrain to right of prev button
            NSDictionary *views = NSDictionaryOfVariableBindings(prevButton, button);
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[prevButton][button(==prevButton)]" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button(==prevButton)]|" options:0 metrics:nil views:views]];
        } else {
            // constrain first button to left of view
            NSDictionary *views = NSDictionaryOfVariableBindings(button);
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|" options:0 metrics:nil views:views]];
            
            NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
            NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
            [self addConstraints:@[width, height]];
        }
        
        prevButton = button;
    }
    
    [self layoutIfNeeded];
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
    [button setBackgroundImage:[UIImage imageNamed:@"rating-star-unselected"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"rating-star-selected"] forState:UIControlStateSelected];
    if([self respondsToSelector:@selector(buttonPressed:)]) {
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

-(void)setRating:(NSInteger)rating {
    NSInteger numOfButtons = self.buttons.count;
    if(rating < 0 && rating > numOfButtons) {
        return;
    }
    for(NSInteger i = 0; i < numOfButtons; i++) {
        UIButton *button = self.buttons[i];

        // 1. fade out button
        [UIView animateWithDuration:0.1 delay:i*0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            button.alpha = 0.f;

            // 3. fade in button
            [UIView animateWithDuration:0.1 delay:i*0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                button.alpha = 1.f;
                
                // 4. if it's the max rating...
                if(i == rating) {
                  
                    // 5. explode button
                    [UIView animateWithDuration:0.1 delay:i*0.1 options:UIViewAnimationOptionCurveLinear animations:^{
                        button.transform = CGAffineTransformMakeScale(1.5, 1.5);
                    } completion:^(BOOL finished) {
                    
                        // 6. implode button
                        [UIView animateWithDuration:0.2 animations:^{
                            button.transform = CGAffineTransformIdentity;
                        }];
                    }];
                }
            } completion:nil];
        } completion:^(BOOL finished) {
            // 2. finished fading out? then set its selected value
            button.selected = (i <= rating);
        }];
    }
}

#pragma mark - ib actions

-(void)buttonPressed:(UIButton *)button {
    NSInteger rating = [self.buttons indexOfObject:button];
    if(rating == NSNotFound) {
        return;
    }
    [self setRating:rating];
    
    if([self.delegate respondsToSelector:@selector(ratingView:selectedRating:)]) {
        [self.delegate ratingView:self selectedRating:rating];
    }
}

@end