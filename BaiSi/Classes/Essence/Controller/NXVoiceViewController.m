//
//  NXVoiceViewController.m
//  BaiSi
//
//  Created by N-X on 2017/2/10.
//  Copyright © 2017年 Marauder. All rights reserved.
//

#import "NXVoiceViewController.h"
static NSString * const cellID = @"voiceCell";

@interface NXVoiceViewController ()

@end

@implementation NXVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(NXNavMaxY + NXTitlesViewH, 0, NXTabBarH, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",self.class,indexPath.row];
    return cell;
}




@end
