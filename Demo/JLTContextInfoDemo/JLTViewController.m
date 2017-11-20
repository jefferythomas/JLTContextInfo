//
//  JLTViewController.m
//  JLTContextInfoDemo
//
//  Created by Jeffery Thomas on 3/7/13.
//  Copyright (c) 2013 JLT Source. All rights reserved.
//

#import "JLTViewController.h"
#import "NSObject+JLTContextInfo.h"

#if defined(JLT_PREFIX_CATEGORIES)
#define contextInfo JLT_contextInfo
#endif

@interface JLTViewController () <UIAlertViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@end

@implementation JLTViewController

- (IBAction)buttonTextToMagic:(UIButton *)button
{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Make Magic"
                                                        message:@"Make the button title \"Magic!\"?"
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
#pragma GCC diagnostic pop

    alertView.contextInfo[@"button"] = button;
    [alertView show];
}

- (IBAction)connectToGoogle:(UIButton *)button
{
    NSURL *URL = [NSURL URLWithString:@"https://google.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
#pragma GCC diagnostic pop
    connection.contextInfo[@"button"] = button;
}

#pragma mark UIAlertViewDelegate

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.contextInfo[@"button"] != nil) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            UIButton *button = alertView.contextInfo[@"button"];
            [button setTitle:@"Magic!" forState:UIControlStateNormal];
        }
    }
}
#pragma GCC diagnostic pop

#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    connection.contextInfo[@"response"] = response;
    connection.contextInfo[@"responseData"] = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [connection.contextInfo[@"responseData"] appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSHTTPURLResponse *response = connection.contextInfo[@"response"];
    NSData *responseData = connection.contextInfo[@"responseData"];
    NSInteger statusCode = [response statusCode];
    NSInteger dataLength = [responseData length];

    NSLog(@"Status Code: %ld", (long)statusCode);
    NSLog(@"Response Body Length: %ld", (long)dataLength);

    if (connection.contextInfo[@"button"] != nil) {
        UIButton *button = connection.contextInfo[@"button"];
        NSString *title = [NSString stringWithFormat:@"%ld-%ld", (long)statusCode, (long)dataLength];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);

    if (connection.contextInfo[@"button"] != nil) {
        UIButton *button = connection.contextInfo[@"button"];
        NSString *title = @"Connection Failed";
        [button setTitle:title forState:UIControlStateNormal];
    }
}

@end
