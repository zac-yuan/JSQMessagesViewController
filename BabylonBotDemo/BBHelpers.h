
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// App colors
#define BBCheckBlueColor [UIColor colorWithRed:10. / 255.  green:142. / 255. blue:232. /255. alpha:1.000]

#define BBLightBlueColor [UIColor colorWithRed:0.338 green:0.602 blue:0.750 alpha:1.000]
#define BBPinkColor [UIColor colorWithRed:0.946 green:0.423 blue:0.309 alpha:1.000]
#define BBOrangeColor [UIColor colorWithRed:0.984 green:0.684 blue:0.362 alpha:1.000]
#define BBGreenColor [UIColor colorWithRed:116. / 255 green:216. / 255 blue:120. / 255 alpha:1.000]
#define BBPurpleColor [UIColor colorWithRed:144. / 255. green:19. / 255. blue:254. / 255. alpha:1.000]

#define BBKitPinkColor [UIColor colorWithRed:224 / 255. green:98 / 255. blue:165 / 255. alpha:1.000]

#define BBKitPinkColor [UIColor colorWithRed:224 / 255. green:98 / 255. blue:165 / 255. alpha:1.000]

#define BBLightBlueTransparentColor [UIColor colorWithRed:0.338 green:0.602 blue:0.750 alpha:0.300]
#define BBPinkTransparentColor [UIColor colorWithRed:0.946 green:0.423 blue:0.309 alpha:0.300]
#define BBOrangeTransparentColor [UIColor colorWithRed:0.984 green:0.684 blue:0.362 alpha:0.300]
#define BBGreenTransparentColor [UIColor colorWithRed:0.674 green:0.829 blue:0.452 alpha:0.300]

#define BBMembershipTitleGrey [UIColor colorWithRed:51 / 255. green:51 / 255. blue:51 / 255. alpha:1.000]
#define BBMembershipSubtitleGrey [UIColor colorWithRed:102 / 255. green:102 / 255. blue:102 / 255. alpha:1.000]

@interface BBHelpers : NSObject

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)msg;

+ (UIColor *)randomColor;

@end
