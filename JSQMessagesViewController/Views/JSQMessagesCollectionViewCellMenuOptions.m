//
//  JSQMessagesCollectionViewCellMenuOptions.m
//  JSQMessages
//
//  Created by Robitto on 09/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellMenuOptions.h"

@implementation JSQMessagesCollectionViewCellMenuOptions

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentRight;
    self.cellBottomLabel.textAlignment = NSTextAlignmentRight;
}

@end
