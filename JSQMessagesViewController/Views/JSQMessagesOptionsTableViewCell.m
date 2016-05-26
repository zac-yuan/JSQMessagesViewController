//
//  JSQMessagesOptionsTableViewCell.m
//  JSQMessages
//
//  Created by Lee Arromba on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQMessagesOptionsTableViewCell.h"

@implementation JSQMessagesOptionsTableViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.preservesSuperviewLayoutMargins = NO;
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
}

@end
