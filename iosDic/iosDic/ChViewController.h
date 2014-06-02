//
//  ChViewController.h
//  iosDic
//
//  Created by PC6 on 2014. 6. 1..
//  Copyright (c) 2014년 PC6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DicDataBase.h"

@interface ChViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchDisplayDelegate>
{
    DicDataBase *pDataBase ;
}

@property (nonatomic, strong) NSString *bookNum;
@property (nonatomic, strong) NSString *chapNum;
@property (nonatomic, assign) BOOL sideMenuCheck;

- (IBAction)cancel:(id)sender;  // 뒤로가기 버튼
- (IBAction)sideback;

@property (weak, nonatomic) IBOutlet UIView *mainViews;
@property (strong, nonatomic) IBOutlet UITableView *contTableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
