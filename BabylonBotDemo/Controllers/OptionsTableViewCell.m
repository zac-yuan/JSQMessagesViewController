//
//  OptionsTableViewCell.m
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "OptionsTableViewCell.h"

@implementation OptionsTableViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.preservesSuperviewLayoutMargins = NO;
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
}

@end
