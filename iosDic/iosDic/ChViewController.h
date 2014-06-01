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
{
    DicDataBase *pDataBase ;
}

@property (nonatomic, strong) NSString *bookNum;
@property (nonatomic, strong) NSString *chapNum;

- (IBAction)cancel:(id)sender;  // 뒤로가기 버튼

@end
