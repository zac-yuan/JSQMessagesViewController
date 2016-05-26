
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const chatBotApiUrlBase;

// COLORS
@interface UIColor (Babylon)
+ (UIColor *)babylonPurple;
+ (UIColor *)randomColor;
@end

// FONTS
@interface UIFont (Babylon)
+ (UIFont *)babylonRegularFont:(float)fontSize;
+ (UIFont *)babylonMediumFont:(float)fontSize;
@end

// STRINGS
@interface NSString (Babylon)
+ (NSString *)babylonErrorMsg:(NSError *)error;
@end