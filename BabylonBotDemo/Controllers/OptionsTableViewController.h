//
//  JSQMessagesOptionsTableViewController.h
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBOption;

@protocol OptionsDelegate <NSObject>

-(void)sender:(id)sender selectedOption:(BBOption *)selectedOption;

@end

@interface OptionsTableViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) id<OptionsDelegate> delegate;

-(instancetype)initWithDataSource:(NSArray *)dataSource;

@end
