
#import "BBMessagesOption.h"

@implementation BBMessagesOption

+(BBMessagesOption *)optionWithText:(NSString *)text
                           textColor:(UIColor *)textColor
                                font:(UIFont *)font
                     backgroundColor:(UIColor *)backgroundColor
                              height:(CGFloat)height {
    BBMessagesOption *option = [BBMessagesOption new];
    option.text = text;
    option.textColor = textColor;
    option.font = font;
    option.backgroundColor = backgroundColor;
    option.height = height;
    return option;
}

@end
