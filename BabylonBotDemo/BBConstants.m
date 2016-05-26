
#import "BBConstants.h"

//dev-chatscript.babylontesting.co.uk/v1
//staging-chatscript.babylontesting.co.uk/v1
NSString *const chatBotApiUrlBase = @"http://dev-chatscript.babylontesting.co.uk/v1";
const CGFloat kOptionCellHeight = 45.f;
const CGFloat kDefaultFontSize = 16.f;
const CGFloat kDefaultCornerRadii = 15.f;

// COLORS
@implementation UIColor (Babylon)
+ (UIColor *)babylonPurple {return [UIColor colorWithRed:144.0f/255.0f green:19.0f/255.0f blue:254.0f/255.0f alpha:1.0];}
+ (UIColor *)babylonWhite {return [UIColor whiteColor];}
+ (UIColor *)randomColor {
    CGFloat hue = (arc4random()%256/256.0);
    CGFloat saturation = (arc4random()%128/256.0)+0.5;
    CGFloat brightness = (arc4random()%128/256.0)+0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end

// FONTS
@implementation UIFont (Babylon)
+ (UIFont *)babylonRegularFont:(float)fontSize {return [UIFont fontWithName:@"AvenirNext-Regular" size:fontSize];}
+ (UIFont *)babylonMediumFont:(float)fontSize {return [UIFont fontWithName:@"AvenirNext-Medium" size:fontSize];}
@end

// STRINGS
@implementation NSString (Babylon)
+ (NSString *)babylonErrorMsg:(NSError *)error {
    if ([error.localizedFailureReason length]>0) {
        return error.localizedFailureReason;
    } else if ([error.localizedDescription length]>0) {
        return error.localizedDescription;
    } else {
        if ([error.description length]>0) {
            return error.description;
        } else {
            return @"I don't get it. Sorry";
        }
    }
}
@end

// CALAYER
@implementation CALayer (Babylon)
+ (CALayer *)roudedBubbleMaskForRect:(CGRect)rect corners:(UIRectCorner)corners {
    CGSize cornerRadii = CGSizeMake(kDefaultCornerRadii, kDefaultCornerRadii);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
@end