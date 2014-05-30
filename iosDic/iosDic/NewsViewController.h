//
//  NewsViewController.h
//  iosDic
//
//  Created by PC13 on 2014. 5. 27..
//  Copyright (c) 2014년 PC13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)cancelAndDismiss:(id)sender;

@end
