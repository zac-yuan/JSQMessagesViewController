
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//TODO: Remove before release
extern NSString *const kChatBotApiToken;
extern NSString *const kChatBotApiUserId;
//-------- end

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

@interface UIImage (Babylon)
+ (UIImage *)babylonBotHearth;
+ (UIImage *)homeScreenBackgroundImage;
@end

@interface CALayer (Babylon)
+ (CALayer *)roudedBubbleMaskForRect:(CGRect)rect corners:(UIRectCorner)corners;
@end