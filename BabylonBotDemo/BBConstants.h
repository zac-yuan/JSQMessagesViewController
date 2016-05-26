
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const chatBotApiUrlBase;
extern const CGFloat kOptionCellHeight;
extern const CGFloat kDefaultFontSize;

// COLORS
@interface UIColor (Babylon)
+ (UIColor *)babylonPurple;
+ (UIColor *)babylonWhite;
+ (UIColor *)randomColor;
@end

// FONTS
@interface UIFont (Babylon)
+ (UIFont *)babylonRegularFont:(float)fontSize;
+ (UIFont *)babylonMediumFont:(float)fontSize;
@end

@interface CALayer (Babylon)
+ (CALayer *)roudedBubbleMaskForRect:(CGRect)rect corners:(UIRectCorner)corners;
@end