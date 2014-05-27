//
//  DicViewController.h
//  iosDic
//
//  Created by PC13 on 2014. 5. 26..
//  Copyright (c) 2014년 PC13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DicViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>//



@property(nonatomic, assign) BOOL sideMenuCheck;
@property (strong, nonatomic) IBOutlet UITableView *sideMenu;

@property(nonatomic, strong) IBOutlet UIView *mainViews;

- (IBAction)cancelAndDismiss:(id)sender;
- (IBAction) sideMenuBtn ;


@end
