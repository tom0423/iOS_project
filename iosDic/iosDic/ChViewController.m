//
//  ChViewController.m
//  iosDic
//
//  Created by PC6 on 2014. 6. 1..
//  Copyright (c) 2014년 PC6. All rights reserved.
//

#import "ChViewController.h"

@implementation ChViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// 뒤로가기 버튼 클릭시
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
