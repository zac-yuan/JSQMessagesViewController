//
//  JSQMessagesOption.m
//  JSQMessages
//
//  Created by BabylonHealth on 26/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQMessagesOption.h"

@implementation JSQMessagesOption

+(JSQMessagesOption *)optionWithText:(NSString *)text
                           textColor:(UIColor *)textColor
                                font:(UIFont *)font
                     backgroundColor:(UIColor *)backgroundColor
                              height:(CGFloat)height {
    JSQMessagesOption *option = [JSQMessagesOption new];
    option.text = text;
    option.textColor = textColor;
    option.font = font;
    option.backgroundColor = backgroundColor;
    option.height = height;
    return option;
}

@end
