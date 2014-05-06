//
//  JLTTableViewController.m
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 5/6/14.
//  Copyright (c) 2014 JLT Source. All rights reserved.
//

#import "JLTTableViewController.h"
#import "NSObject+JLTContextInfo.h"

@implementation JLTTableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *datum = self.data[indexPath.row];

    return [datum.contextInfo[@"isExpanded"] boolValue] ? 88.0 : 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *datum = self.data[indexPath.row];

    BOOL isExpanded = [datum.contextInfo[@"isExpanded"] boolValue];
    datum.contextInfo[@"isExpanded"] = !isExpanded ? @YES : @NO;

    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray *)data
{
    if (!_data) _data = @[@"1", @"2", @"3", @"4", @"5"];
    return _data;
}

@end
