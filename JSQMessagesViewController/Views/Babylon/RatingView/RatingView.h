//
//  RatingViewController.h
//  JSQMessages
//
//  Created by BabylonHealth on 01/06/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessageMediaData.h"
@class RatingView;
@class JSQMessage;

@protocol RatingViewDelegate <NSObject>

/**
 @param rating The start rating (ranges from 1 - n)
 */
-(void)ratingView:(RatingView *)ratingView selectedRating:(NSInteger)rating;
@end

@interface RatingView : UIView <JSQMessageMediaData>
@property (nonatomic, weak) id<RatingViewDelegate>delegate;
@property (nonatomic, weak) JSQMessage *message;
-(void)setRating:(NSInteger)rating;
@end
