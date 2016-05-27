//
//  JSQMessagesOptionsTableViewCell.h
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kJSQMessagesOptionsTableViewCellReuseId = @"JSQMessagesOptionsTableViewCell";

@interface JSQMessagesOptionsTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *optionNameLabel;

@end
