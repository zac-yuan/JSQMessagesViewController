//
//  RatingViewController.h
//  JSQMessages
//
//  Created by BabylonHealth on 01/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingView;

@protocol RatingViewDelegate <NSObject>

/**
 @param rating The start rating (ranges from 1 - n)
 */
-(void)ratingView:(RatingView *)ratingView selectedRating:(NSInteger)rating;

@end

@interface RatingView : UIView

@property (nonatomic, weak) id<RatingViewDelegate>delegate;

-(instancetype)initWithNumberOfButtons:(NSInteger)numberOfButtons
                              maxWidth:(CGFloat)maxWidth
                         initialRating:(NSInteger)rating;
-(void)setRating:(NSInteger)rating;

@end
