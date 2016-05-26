//
//  JSQMessagesOptionsTableViewController.m
//  JSQMessages
//
//  Created by Lee Arromba on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQMessagesOptionsTableViewController.h"
#import "JSQMessagesOptionsTableViewCell.h"
#import "JSQMessagesOption.h"
#import "UIView+JSQMessages.h"

static const CGFloat kTableCellHeight = 30.f;

@interface JSQMessagesOptionsTableViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation JSQMessagesOptionsTableViewController

-(instancetype)initWithDataSource:(NSArray *)dataSource {
    self = [super init];
    if(self) {
        self.dataSource = dataSource;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    // the height of the bubble is calculated elsewhere. It uses the size of this media view + any text. We need to ensure the height of this view is set as the calculation is taken from the view's frame. Even though autolayout is used, the setup code executes before the view is added. We make the width 0 so the calculation uses the biggest width (i.e. from the text, not this view).
    self.view.frame = CGRectMake(0.f, 0.f, 0.f, dataSource.count * kTableCellHeight);
}

-(void)setupUi {
    // tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    Class classId = [JSQMessagesOptionsTableViewCell class];
    UINib *nib = [UINib nibWithNibName:kJSQMessagesOptionsTableViewCellReuseId bundle:[NSBundle bundleForClass:classId]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kJSQMessagesOptionsTableViewCellReuseId];
    
    // view
    [self.view addSubview:self.tableView];
    [self.view jsq_pinAllEdgesOfSubview:self.tableView];
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count =  self.dataSource ? self.dataSource.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JSQMessagesOptionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kJSQMessagesOptionsTableViewCellReuseId forIndexPath:indexPath];
    JSQMessagesOption *option = self.dataSource[indexPath.row];
    cell.optionNameLabel.text = option.text;
    cell.optionNameLabel.textColor = option.textColor;
    cell.backgroundColor = option.backgroundColor;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableCellHeight;
}

@end