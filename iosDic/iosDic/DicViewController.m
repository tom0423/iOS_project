//
//  DicViewController.m
//  iosDic
//
//  Created by PC13 on 2014. 5. 26..
//  Copyright (c) 2014년 PC13. All rights reserved.
//

#import "DicViewController.h"

@interface DicViewController ()

//@property (strong, nonatomic) NSArray *FirstArray ;
//@property (strong, nonatomic) NSArray *searchResult;

@end

@implementation DicViewController
{
    NSArray *FirstArray;
    NSArray *searchResult;
}

@synthesize sideMenu;
@synthesize mainViews;
@synthesize sideMenuCheck;

#define SizeX 0
#define SizeY 0
#define SizeWidth 320
#define SizeHeight 460

#define SizeInterval 320

-(void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FirstArray = [NSArray arrayWithObjects:
                       @"제 1권 : 소아청소년 응급의료",
                       @"제 2권 : 소아청소년 질병, 안전사고 예방",
                       @"제 3권 : 소아청소년 성장 발육 육아",
                       @"제 4권 : 모유, 모유수유, 이유",
                       @"제 5권 : 인공영약, 우유, 이유식, 비타민, 미네랄, 단백질, 탄수화물, 지방",
                       @"제 6권 : ",
                       @"제 7권 : ",
                       @"제 8권 : ",
                       @"제 9권 : ",
                       @"제 10권 : ",
                       @"제 11권 : ",
                       @"제 12권 : ",
                       @"제 13권 : ",
                       @"제 14권 : ",
                       @"제 15권 : ",
                       @"제 16권 : ",
                       @"제 17권 : ",
                       @"제 18권 : ",
                       @"제 19권 : ",
                       @"제 20권 : ",
                       @"제 21권 : ",
                       @"제 22권 : ",
                       @"제 23권 : ",
                       @"제 24권 : ",
                       @"제 25권 : ",
                       nil] ;
   // searchResult =  [[NSArray alloc] init];
    
    sideMenuCheck = true;
    [sideMenu setDataSource:self];
    [sideMenu setDelegate:self];
}

// 뒤로가기 버튼 클릭시
- (IBAction)cancelAndDismiss:(id)sender {
    NSLog(@"Cancle");
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Dismiss complete!");
        
    }];
}

// item 버튼 클릭시
- (IBAction) sideMenuBtn
{
    CGRect viewFram = mainViews.frame;
    [sideMenu reloadData];
    if (sideMenuCheck == true)
    {
        viewFram.origin.x = -250 ;
        sideMenuCheck = false;
    }else{
        viewFram.origin.x = 0 ;
        sideMenuCheck = true;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    
    [mainViews setFrame:viewFram];
    
    [UIView commitAnimations];
}

// ----------------------------------------------------------------------------
//   Slide Menu Bar :: Table view에 관한 메소드들
// ----------------------------------------------------------------------------

// 해당 그룹의 세션 나누기
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 5/27 LHS:검색 기능 구현중 ㅎ
    if(tableView == self.searchDisplayController.searchResultsTableView )
    {
        return [searchResult count];
        
    }
    else
    {
        return [FirstArray count] ;
    }
}

// 그룹 타이틀 입력
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *testView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 10)];
    testView.backgroundColor = [UIColor blackColor];
    testView.textColor = [UIColor whiteColor];
    
    // 변수 section : 그룹의 번호를 나타낸다
    switch (section) {
        case 0:
            testView.text =@"  소아가정 간호백과";
            break;
            
        default:
            testView.text =@"";
            break;
    }
    
    return testView;
}

#pragma mark - tableView cellForRowAtIndexPath : 테이블 뷰의 셀을 생성

// 기능 : 정보에 따라 안에 값들을 만들어준다.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [sideMenu dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if(tableView == self.searchDisplayController.searchResultsTableView )
    {
        cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text =[FirstArray objectAtIndex:indexPath.row] ;
    }
  /*
    NSArray *viewsToRemove1 = [cell subviews];
    for (UIView *v in viewsToRemove1)
    {
        if (v.tag == 111111) {
            [v removeFromSuperview];
        }
    }


    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 20)];
    text.backgroundColor = [UIColor clearColor];
    text.textColor =[UIColor blackColor];
    text.font = [UIFont systemFontOfSize:14];
    text.tag = 111111;
 
    text.text = [self.FirstArray objectAtIndex:indexPath.row] ;
 */

  //  [cell addSubview:text];
    return cell;
}

#pragma serach methods 
-(void) filterContentForSeachText:(NSString *) searchText scope:(NSString *) scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF biginswith[c] %@", searchText];
    searchResult = [FirstArray filteredArrayUsingPredicate: predicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSeachText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex ]]];
    
    return YES;
}

#pragma mark - tableView didSelectRowAtIndexPath(각각 셀 만드는 메소드)
// 기능 : 각각 셀을 선택하였을 때
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d열 %d행 번째",indexPath.section,[indexPath row]);
    
    if (indexPath.section == 0) {
        CGPoint point;
        point.y = SizeY;
        if (indexPath.row == 0) {
            point.x = SizeX;
        }else if(indexPath.row == 1){
            point.x = SizeX+SizeWidth;
        }else if(indexPath.row == 2){
            point.x = SizeX+SizeWidth+SizeWidth;
        }else if(indexPath.row == 3){
            point.x = SizeX+SizeWidth+SizeWidth+SizeWidth;
        }
        [self sideMenuBtn];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  // 해제
}

@end
