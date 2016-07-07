
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BBDotActivityIndicatorParms : NSObject

@property (nonatomic) NSUInteger numberOfCircles;
@property (nonatomic) CGFloat internalSpacing;
@property (nonatomic) CGFloat circleWidth;
@property (nonatomic) CGFloat animationDelay;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGFloat animationFromValue;
@property (nonatomic) CGFloat animationToValue;
@property (nonatomic) CGFloat activityViewWidth;
@property (nonatomic) CGFloat activityViewHeight;
@property (strong, nonatomic) UIColor *defaultColor;
@property (nonatomic) BOOL isDataValidationEnabled;

-(instancetype)initWithDefaultData;

@end
