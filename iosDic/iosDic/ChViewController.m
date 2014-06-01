//
//  ChViewController.m
//  iosDic
//
//  Created by PC6 on 2014. 6. 1..
//  Copyright (c) 2014년 PC6. All rights reserved.
//

#import "ChViewController.h"

@implementation ChViewController
{
    NSMutableArray *ContentsArray ;
}

@synthesize bookNum ;
@synthesize chapNum ;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"d");
    NSLog(@"bkNum = %d, chNum = %d",[bookNum intValue], [chapNum intValue]);
    
    // 데이터베이스
    pDataBase = [[DicDataBase alloc] init ] ;
    ContentsArray = [pDataBase getContentsList:[bookNum intValue] :[chapNum intValue]];
    
    NSLog(@"contents cnt=%d",[ContentsArray count]);
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

// 테이블 세션 나누기
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ContentsArray count];
}

#pragma mark - tableView cellForRowAtIndexPath : 테이블 뷰의 셀을 생성

// 기능 : 정보에 따라 안에 값들을 만들어준다.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor] ;
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
 
    cell.textLabel.text = [ContentsArray objectAtIndex:indexPath.row];
    
    return cell;
}

// 기능 : 각각 셀을 선택하였을 때
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d열 %d행 번째",indexPath.section,[indexPath row]);
 
    //
    // 셀을 선택했을때의 기능 추가
    //
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
}


@end
