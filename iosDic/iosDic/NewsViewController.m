//
//  NewsViewController.m
//  iosDic
//
//  Created by PC13 on 2014. 5. 27..
//  Copyright (c) 2014년 PC13. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController()

@end


@implementation NewsViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *str = @"http://www.koreapediatrics.com/news";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [self.webView loadRequest:request];
    
}


- (IBAction)cancelAndDismiss:(id)sender {
    NSLog(@"Cancle");
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismiss complete!");
        
    }];
}

@end
