//
//  JSQViewMediaItem.m
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQViewMediaItem.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

@interface JSQViewMediaItem ()

@property (strong, nonatomic) UIView *cachedMediaContainer;

@end

@implementation JSQViewMediaItem

@synthesize media = _media;

- (instancetype)initWithViewMedia:(UIView *)view
{
    self = [super init];
    if (self) {
        _media = view;
        _cachedMediaContainer = nil;
    }
    return self;
}

- (instancetype)initWithViewMedia:(UIView *)view andUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        _media = view;
        _cachedMediaContainer = nil;
        _url = url;
    }
    return self;
}

- (void)clearCachedMediaViews
{
    [super clearCachedMediaViews];
    _cachedMediaContainer = nil;
}

#pragma mark - Setters

- (void)setMedia:(UIView *)media
{
    _media = media;
    _cachedMediaContainer = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedMediaContainer = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (CGSize)mediaViewDisplaySize
{
    return self.media.frame.size;
}

- (UIView *)mediaView
{
    if (_media == nil) {
        return nil;
    }
    
    if (self.cachedMediaContainer == nil) {
        UIView *view = _media;
        if (self.shouldApplyMask) {
            [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:view
                                                                        isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        }
        self.cachedMediaContainer = view;
    }
    
    return self.cachedMediaContainer;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

- (NSString *)mediaDataType
{
    return [NSString string];
}

- (id)mediaData
{
    return self.media;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    return super.hash ^ self.media.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: media=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.media, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _media = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(media))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.media forKey:NSStringFromSelector(@selector(media))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQViewMediaItem *copy = [[JSQViewMediaItem allocWithZone:zone] initWithViewMedia:self.media];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}


@end
