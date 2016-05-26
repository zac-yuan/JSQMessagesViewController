//
//  JSQMessagesOption.m
//  JSQMessages
//
//  Created by Lee Arromba on 26/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQMessagesOption.h"

@implementation JSQMessagesOption

+(JSQMessagesOption *)optionWithText:(NSString *)text
                           textColor:(UIColor *)textColor
                     backgroundColor:(UIColor *)backgroundColor {
    JSQMessagesOption *option = [JSQMessagesOption new];
    option.text = text;
    option.textColor = textColor;
    option.backgroundColor = backgroundColor;
    return option;
}

@end
