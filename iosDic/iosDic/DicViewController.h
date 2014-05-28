//
//  DicViewController.h
//  iosDic
//
//  Created by PC13 on 2014. 5. 26..
//  Copyright (c) 2014년 PC13. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DicViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,UISearchDisplayDelegate>//



@property(nonatomic, assign) BOOL sideMenuCheck;   // 슬라이딩 메뉴가 선택되었는지 유무
@property (strong, nonatomic) IBOutlet UITableView *sideMenu; // 슬라이딩메뉴

@property(nonatomic, strong) IBOutlet UIView *mainViews; // NavigationBar가 포함된 메인뷰

@property (strong, nonatomic) IBOutlet UITextView *testingText; // KimDB : 슬라이딩 메뉴의 선택된 항목 출력

- (IBAction)cancelAndDismiss:(id)sender;
- (IBAction) sideMenuBtn ;


@end
