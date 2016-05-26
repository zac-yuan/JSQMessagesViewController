//
//  JSQMessagesOption.h
//  JSQMessages
//
//  Created by Lee Arromba on 26/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSQMessagesOption : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat height;

+(JSQMessagesOption *)optionWithText:(NSString *)text
                           textColor:(UIColor *)textColor
                                font:(UIFont *)font
                     backgroundColor:(UIColor *)backgroundColor
                              height:(CGFloat)height;

@end
