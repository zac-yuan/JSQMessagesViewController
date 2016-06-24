
#import <UIKit/UIKit.h>
#import "BBChatBotDataModelChosenOption.h"

@class JSQMessage;

@interface BBOption : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) BBChatBotDataModelChosenOption *optionSelected;
@property (nonatomic, strong) JSQMessage *message;

+(BBOption *)optionWithText:(NSString *)text
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font
            backgroundColor:(UIColor *)backgroundColor
                     height:(CGFloat)height
             optionSelected:(BBChatBotDataModelChosenOption *)optionSelected;

@end
