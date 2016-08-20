//
//  UIFont+JSQMessages.m
//  JSQMessages
//
//  Created by Robitto on 14/07/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "UIFont+JSQMessages.h"

@implementation UIFont (JSQMessages)

+ (UIFont *)babylonLightFont:(CGFloat)size {
    return [UIFont fontWithName:@".SFUIText-Light" size:size];
}

+ (UIFont *)babylonRegularFont:(CGFloat)size {
    return [UIFont fontWithName:@".SFUIText-Regular" size:size];
}

+ (UIFont *)babylonMediumFont:(CGFloat)size {
    return [UIFont fontWithName:@".SFUIText-Medium" size:size];
}

@end
