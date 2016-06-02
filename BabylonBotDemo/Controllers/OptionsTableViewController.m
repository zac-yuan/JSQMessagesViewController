//
//  JSQMessagesOptionsTableViewController.m
//  JSQMessages
//
//  Created by BabylonHealth on 25/05/2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "OptionsTableViewController.h"
#import "OptionsTableViewCell.h"
#import "BBOption.h"
#import "UIView+JSQMessages.h"
#import "BBConstants.h"

@interface OptionsTableViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation OptionsTableViewController

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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(!self.tableView.layer.mask) {
        self.tableView.layer.mask = [CALayer roudedBubbleMaskForRect:self.tableView.bounds corners:UIRectCornerBottomLeft|UIRectCornerBottomRight];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    // the height of the bubble is calculated elsewhere. The calculation is the size of this view + the text size. We need to ensure the height of this view is set on setting the data source, as bubble calculation uses this view's frame. Even though autolayout is used, the setup code executes before the view is added and the size automatically calcualted. We make the width 0 so the calculation uses the biggest width (i.e. width of the text, not this view which defaults to total screen width).
    CGFloat height = 0;
    for(BBOption *option in dataSource) {
        height += option.height;
    }
    self.view.frame = CGRectMake(0.f, 0.f, 0.f, height);
}

-(void)setupUi {
    // tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 0.f, 1.f)]; // removes last separator
    Class classId = [OptionsTableViewCell class];
    UINib *nib = [UINib nibWithNibName:kOptionsTableViewCellReuseId bundle:[NSBundle bundleForClass:classId]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kOptionsTableViewCellReuseId];

    // view
    [self.view addSubview:self.tableView];
    [self.view jsq_pinAllEdgesOfSubview:self.tableView withPadding:2.f];
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
    OptionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOptionsTableViewCellReuseId forIndexPath:indexPath];
    BBOption *option = self.dataSource[indexPath.row];
    cell.optionNameLabel.text = option.text;
    cell.optionNameLabel.textColor = option.textColor;
    cell.optionNameLabel.font = option.font;
    cell.backgroundColor = option.backgroundColor;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.delegate respondsToSelector:@selector(sender:selectedOption:)]) {
        [self.delegate sender:self selectedOption:self.dataSource[indexPath.row]];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBOption *option = self.dataSource[indexPath.row];
    return option.height;
}

@end