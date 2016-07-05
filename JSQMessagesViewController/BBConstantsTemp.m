
#import "BBConstantsTemp.h"
#import "JSQMessages.h"

//dev-chatscript.babylontesting.co.uk/v1
//staging-chatscript.babylontesting.co.uk/v1

NSString *const kChatBotApiToken            = @"debc6543cd3bc7abca7380e22568d7c6";
NSString *const kChatBotApiUserId           = @"2742";

NSString *const kPubNubPublishKey           = @"pub-c-63c4d0c1-0085-4719-962f-fbc211d4f90a";
NSString *const kPubNubSubscribeKey         = @"sub-c-67d2f8fe-20ed-11e6-b700-0619f8945a4f";
NSString *const kPubNubSecretKey            = @"sec-c-NmNkYTRlMTAtYTIwZC00YzgwLTllNjAtNzQzYTAwMzg4YjYw";

NSString *const kChatBotApiUrlBase          = @"http://dev-chatscript.babylontesting.co.uk/v1";
NSString *const kBabylonDoctorName          = @"Dr. Babylon";
NSString *const kBabylonDoctorId            = @"babyBot";

const CGFloat kOptionCellHeight             = 45.f;
const CGFloat kDefaultFontSize              = 16.f;
const CGFloat kDefaultCornerRadii           = 15.f;

#pragma mark - UIFont
@implementation UIFont (Babylon)
+ (UIFont *)babylonRegularFont:(float)fontSize {return [UIFont fontWithName:@"AvenirNext-Regular" size:fontSize];}
+ (UIFont *)babylonMediumFont:(float)fontSize {return [UIFont fontWithName:@"AvenirNext-Medium" size:fontSize];}
@end

#pragma mark - UIImage
@implementation UIImage (Babylon)
+ (UIImage *)babylonBotHearth {
    return [UIImage imageNamed:@"bot-heart"];
}
+ (UIImage *)homeScreenBackgroundImage {
    return [UIImage imageNamed:@"homeScreenBackground"];
}
@end

#pragma mark - CALayer
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