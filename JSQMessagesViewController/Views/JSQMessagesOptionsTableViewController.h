//
//  JSQMessagesOptionsTableViewController.h
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSQMessagesOptionsTableViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

-(instancetype)initWithDataSource:(NSArray *)dataSource;

@end
