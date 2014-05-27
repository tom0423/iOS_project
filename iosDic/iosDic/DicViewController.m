//
//  DicViewController.m
//  iosDic
//
//  Created by PC13 on 2014. 5. 26..
//  Copyright (c) 2014년 PC13. All rights reserved.
//

#import "DicViewController.h"

@interface DicViewController ()

@end

@implementation DicViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)cancelAndDismiss:(id)sender {
    NSLog(@"Cancle");
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismiss complete!");
        
    }];
}

@end
