//
//  JSQViewMediaItem.h
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Babylon Health. All rights reserved.
//

#import "JSQMediaItem.h"

/**
 *  The `JSQViewMediaItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` 
 *  protocol and represents a view media message. An initialized `JSQViewMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQViewMediaItem` to provide additional functionality or behavior.
 */
@interface JSQViewMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying>

/**
 *  The media for the mixed media item. The default value is `nil`.
 */
@property (strong, nonatomic) UIView *media;

- (instancetype)initWithViewMedia:(UIView *)media;
- (instancetype)initWithViewControllerMedia:(UIViewController *)media;

@end
