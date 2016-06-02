
#import <UIKit/UIKit.h>
#import "BBChatBotDataModelChosenOption.h"

@interface BBOption : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) BBChatBotDataModelChosenOption *optionSelected;

+(BBOption *)optionWithText:(NSString *)text
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font
            backgroundColor:(UIColor *)backgroundColor
                     height:(CGFloat)height
             optionSelected:(BBChatBotDataModelChosenOption *)optionSelected;

@end
