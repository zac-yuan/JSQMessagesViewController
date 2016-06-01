
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const kPubNubPublishKey;
extern NSString *const kPubNubSubscribeKey;
extern NSString *const kPubNubSecretKey;
extern NSString *const kChatBotApiUrlBase;
extern NSString *const kBabylonDoctorName;
extern NSString *const kBabylonDoctorId;

extern const CGFloat kOptionCellHeight;
extern const CGFloat kDefaultFontSize;

@interface UIColor (Babylon)
+ (UIColor *)babylonPurple;
+ (UIColor *)babylonWhite;
+ (UIColor *)randomColor;
@end

@interface UIFont (Babylon)
+ (UIFont *)babylonRegularFont:(float)fontSize;
+ (UIFont *)babylonMediumFont:(float)fontSize;
@end

@interface NSString (Babylon)
+ (NSString *)babylonErrorMsg:(NSError *)error;
+ (NSString *)babylonBadgeCounter:(NSArray *)messages;
@end

@interface UIImage (Babylon)
+ (UIImage *)babylonBotHearth;
+ (UIImage *)homeScreenBackgroundImage;
@end

@interface CALayer (Babylon)
+ (CALayer *)roudedBubbleMaskForRect:(CGRect)rect corners:(UIRectCorner)corners;
@end