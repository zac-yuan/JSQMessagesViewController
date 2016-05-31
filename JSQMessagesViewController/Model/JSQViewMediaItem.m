//
//  JSQViewMediaItem.m
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQViewMediaItem.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"
#import "UIView+JSQMessages.h"

@interface JSQViewMediaItem ()

@property (strong, nonatomic) UIView *cachedMediaContainer;
@property (strong, nonatomic) UIViewController *viewController;

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

- (instancetype)initWithViewControllerMedia:(UIViewController *)media {
    self = [self initWithViewMedia:media.view];
    if (self) {
        self.viewController = media;
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
    _viewController = nil;
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
    if (self.media == nil) {
        return nil;
    }
    
    if (self.cachedMediaContainer == nil) {
        UIView *view = [[UIView alloc] initWithFrame:self.media.bounds];
        view.backgroundColor = [UIColor clearColor];
        self.media.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:self.media];
        [view jsq_pinAllEdgesOfSubview:self.media];
        self.cachedMediaContainer = view;
    }
    
    return self.cachedMediaContainer;
}

- (NSUInteger)mediaHash
{
    return self.media.hash;
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
        _viewController = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(viewController))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.media forKey:NSStringFromSelector(@selector(media))];
    [aCoder encodeObject:self.viewController forKey:NSStringFromSelector(@selector(viewController))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQViewMediaItem *copy;
    if(self.viewController) {
        copy = [[JSQViewMediaItem allocWithZone:zone] initWithViewControllerMedia:self.viewController];
    } else {
        copy = [[JSQViewMediaItem allocWithZone:zone] initWithViewMedia:self.media];
    }
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}


@end
