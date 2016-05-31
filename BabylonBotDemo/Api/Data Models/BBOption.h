
#import <UIKit/UIKit.h>

@interface BBOption : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat height;

+(BBOption *)optionWithText:(NSString *)text
                           textColor:(UIColor *)textColor
                                font:(UIFont *)font
                     backgroundColor:(UIColor *)backgroundColor
                              height:(CGFloat)height;

@end
