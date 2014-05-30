//
//  NewsViewController.m
//  iosDic
//
//  Created by PC13 on 2014. 5. 27..
//  Copyright (c) 2014년 PC13. All rights reserved.
//

#import "NewsViewController.h"

#define URL_str @"http://www.koreapediatrics.com/news" //LHS: 소아과학 새소식 주소

@interface NewsViewController()

@end


@implementation NewsViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.webView.scalesPageToFit = YES; //LHS: 웹페이지를 웹뷰에 맞게 크기 조절
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_str]]; //LHS: URL 주소 지정
    
    
    [self.webView loadRequest:request]; //LHS:지정된 주소를 보여주기
    
}

//LHS: 소아과학 새소식 내의 웹뷰에서 앞으로가기, 뒤로 가기 , home버튼에 대한 기능
- (IBAction)barButtonClick:(UIBarButtonItem *)sender {
    NSInteger buttonTag = [sender tag];
    
    
    switch (buttonTag) {
        case 10: //뒤로가기
            if ([self.webView canGoBack]) {
                [self.webView goBack];
            }
            break;
        case 20://앞으로 가기
            if ([self.webView canGoForward]) {
                [self.webView goForward];
            }
            break;
        case 30://home버튼
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URL_str]]];
            break;
        default:
            break;
    }
    
    
}



- (IBAction)cancelAndDismiss:(id)sender {
    NSLog(@"Cancle");
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismiss complete!");
        
    }];
}

@end
