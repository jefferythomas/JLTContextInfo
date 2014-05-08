//
//  JLTTableViewController.m
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 5/6/14.
//  Copyright (c) 2014 JLT Source. All rights reserved.
//

#import "JLTTableViewController.h"
#import "NSObject+JLTContextInfo.h"

@interface JLTDemoModel : NSObject

@property (nonatomic) NSString *text;
+ (instancetype)newWithText:(NSString *)text;
@end

@interface JLTDemoModel (JLTExpandable)
@property (nonatomic, getter = isExpanded) BOOL expanded;
@end

@implementation JLTTableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    JLTDemoModel *datum = self.data[indexPath.row];

    cell.textLabel.text = datum.text;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLTDemoModel *datum = self.data[indexPath.row];

    return datum.expanded ? 88.0 : 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLTDemoModel *datum = self.data[indexPath.row];

    datum.expanded = !datum.expanded;

    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray *)data
{
    if (!_data)
        _data = @[[JLTDemoModel newWithText:@"1"],
                  [JLTDemoModel newWithText:@"2"],
                  [JLTDemoModel newWithText:@"3"],
                  [JLTDemoModel newWithText:@"4"],
                  [JLTDemoModel newWithText:@"5"]];
    return _data;
}

@end

@implementation JLTDemoModel
+ (instancetype)newWithText:(NSString *)text
{
    return [[self alloc] initWithText:text];
}

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self != nil) {
        _text = text;
    }
    return self;
}
@end

@implementation JLTDemoModel (JLTExpandable)
- (BOOL)isExpanded
{
    return [self.contextInfo[@"isExpanded"] boolValue];
}
- (void)setExpanded:(BOOL)expanded
{
    if (expanded)
        self.contextInfo[@"isExpanded"] = @YES;
    else
        [self.contextInfo removeObjectForKey:@"isExpanded"];
}
@end
