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
    NSArray *FirstArray;        // 소아가정백과 권제목에 대한 정보를 담음
    NSArray *searchResult;
    
    NSString *str ;             // KimDB : 슬라이드 메뉴클릭시 텍스트변경 Testing
}

@synthesize sideMenu;
@synthesize mainViews;
@synthesize sideMenuCheck;
@synthesize testingText;    // KimDB : 슬라이드 메뉴클릭시 텍스트변경 Testing
@synthesize SearchBar;

#define SizeX 0
#define SizeY 0
#define SizeWidth 320
#define SizeHeight 460

#define SizeInterval 320

-(void) viewDidLoad
{
    [super viewDidLoad];

    
    FirstArray = [NSArray arrayWithObjects:
                  @"제 1권 : 응급의료",
                  @"제 2권 : 질병, 안전사고 예방",
                  @"제 3권 : 성장, 발육, 육아",
                  @"제 4권 : 모유, 모유수유, 이유",
                  @"제 5권 : 인공영약, 우유, 이유식, 비타민, 미네랄, 단백질, 탄수화물, 지방",
                  @"제 6권 : 신생아의 성장 발육 양육 질환",
                  @"제 7권 : 감염병",
                  @"제 8권 : 호흡기 질환",
                  @"제 9권 : 소화기 질환",
                  @"제 10권 : 신장, 비뇨, 생식기 질환",
                  @"제 11권 : 심장, 혈관계 질환",
                  @"제 12권 : 신경정신 질환, 행동수면 문제",
                  @"제 13권 : 혈액, 림프, 종양 질환",
                  @"제 14권 : 내분비, 유전, 염색체, 대사, 희귀병",
                  @"제 15권 : 알레르기, 자가 면역 질환",
                  @"제 16권 : 정형외과 질환",
                  @"제 17권 : 피부질환",
                  @"제 18권 : 이비인후 질환",
                  @"제 19권 : 안(눈)과 질환",
                  @"제 20권 : 치아 구강 질환",
                  @"제 21권 : 가정, 학교 간호",
                  @"제 22권 : 아들 딸 이렇게 사랑해주세요",
                  @"제 23권 : 사춘기 아이들의 성장 발육 질병",
                  @"제 24권 : 성교육",
                  @"제 25권 : 임신, 분만, 출산, 신생아 돌보기",
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


#pragma mark - tableView didSelectRowAtIndexPath(각각 셀 만드는 메소드)

// 기능 : 각각 셀을 선택하였을 때
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d열 %d행 번째",indexPath.section,[indexPath row]);
    
    // KimDB : 슬라이드 메뉴클릭시 텍스트변경 ----------------------------
    str = [NSString stringWithFormat:@"  > "];
    
    if(tableView == self.searchDisplayController.searchResultsTableView )
    {
        NSString *s2 = [searchResult objectAtIndex:indexPath.row] ;
        str = [str stringByAppendingString:s2] ;
        [self.SearchBar setShowsCancelButton:NO animated:YES] ; //
        [tableView setHidden:YES]; // 검색 결과 테이블뷰를 숨긴다
        
    }
    else // 슬라이딩 메뉴의 테이블뷰
    {
        NSString *s2 = [FirstArray objectAtIndex:indexPath.row] ;
        str = [str stringByAppendingString:s2] ;
    }
    
    testingText.text = str ;
    
    // ------------------------------------------------------------
    
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


// ----------------------------------------------------------------------------
//   Search Bar에 관한 메소드들
// ----------------------------------------------------------------------------

#pragma serach methods 

// 검색 결과인 단어를 searchResult array에 넣음
-(void) filterContentForSeachText:(NSString *) searchText scope:(NSString *) scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    searchResult = [FirstArray filteredArrayUsingPredicate: predicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSeachText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex ]]];
    
    return YES;
}



@end
