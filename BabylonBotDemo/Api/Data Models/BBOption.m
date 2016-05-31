
#import "BBOption.h"

@implementation BBOption

+(BBOption *)optionWithText:(NSString *)text
                           textColor:(UIColor *)textColor
                                font:(UIFont *)font
                     backgroundColor:(UIColor *)backgroundColor
                              height:(CGFloat)height {
    BBOption *option = [BBOption new];
    option.text = text;
    option.textColor = textColor;
    option.font = font;
    option.backgroundColor = backgroundColor;
    option.height = height;
    return option;
}

@end
