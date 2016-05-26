//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "UIView+JSQMessages.h"

@implementation UIView (JSQMessages)

- (void)jsq_pinSubview:(UIView *)subview toEdge:(NSLayoutAttribute)attribute
{
    [self jsq_pinSubview:subview toEdge:attribute padding:0.f];
}

- (void)jsq_pinSubview:(UIView *)subview toEdge:(NSLayoutAttribute)attribute padding:(CGFloat)padding
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:attribute
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:subview
                                                     attribute:attribute
                                                    multiplier:1.0f
                                                      constant:padding]];
}

- (void)jsq_pinAllEdgesOfSubview:(UIView *)subview
{
    [self jsq_pinAllEdgesOfSubview:subview withPadding:0.f];
}

- (void)jsq_pinAllEdgesOfSubview:(UIView *)subview withPadding:(CGFloat)padding {
    [self jsq_pinSubview:subview toEdge:NSLayoutAttributeBottom padding:padding];
    [self jsq_pinSubview:subview toEdge:NSLayoutAttributeTop padding:padding];
    [self jsq_pinSubview:subview toEdge:NSLayoutAttributeLeading padding:-padding];
    [self jsq_pinSubview:subview toEdge:NSLayoutAttributeTrailing padding:padding];
}

@end
