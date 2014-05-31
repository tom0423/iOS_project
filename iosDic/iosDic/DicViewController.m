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
    NSArray *FirstArray;        // 소아가정백과 권제목에 대한 정보들
    NSArray *searchResult;      // 슬라이드 메뉴 검색결과들
    NSString *str ;             // 선택된 Book title
    
    NSMutableArray *ChapterArray ;
    
}

@synthesize mainViews;
@synthesize sideMenuCheck;
@synthesize testingText;    // 선택된 BookTitle
@synthesize SearchBar;
@synthesize sideMenu;       // Book List Table
@synthesize chapterTable;   // Chpater List Table

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

    // 슬라이딩 메뉴 초기화
    sideMenuCheck = true;
    [sideMenu setDataSource:self];
    [sideMenu setDelegate:self];
    
    // 데이터베이스
    pDataBase = [[DicDataBase alloc] init ] ;
    ChapterArray = [ [NSMutableArray alloc] init ] ;
    
    // chapter list 초기화
    [chapterTable setDataSource:self] ;
    [chapterTable setDelegate:self];
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
    else if ( tableView == self.sideMenu )
    {
        return [FirstArray count] ;
    }
    else {
        return ([ChapterArray count]==0)?1:[ChapterArray count] ;
    }
    
}

// 그룹 타이틀 입력
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if ( tableView == self.sideMenu ){
        UILabel *testView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 10)];
        testView.backgroundColor = [UIColor blackColor];
        testView.textColor = [UIColor whiteColor];
        testView.text =@"  소아가정 간호백과";
        
        return testView ;
    }
    return NULL;
}

#pragma mark - tableView cellForRowAtIndexPath : 테이블 뷰의 셀을 생성

// 기능 : 정보에 따라 안에 값들을 만들어준다.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [sideMenu dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor] ;
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if(tableView == self.searchDisplayController.searchResultsTableView )
    {
        cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    }
    else if ( tableView == self.sideMenu )
    {
        cell.textLabel.text =[FirstArray objectAtIndex:indexPath.row] ;
    }
    else if ( tableView == self.chapterTable )
    {
        NSLog(@"chapter array 셀 생성중");
        if ( [ChapterArray count] != 0 ) {
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = [ChapterArray objectAtIndex:indexPath.row] ;
        }
    }
  
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
        
        //[tableView setHidden:YES]; // 검색 결과 테이블뷰를 숨긴다
        //[self.view endEditing:YES]; // 2014.5.28 SRN 검색 결과 키보드를 숨긴다
        
        int i ;
        for ( i=0 ; i<26 ; i++ ) {
           
            if ( [s2 isEqualToString:(NSString*)[FirstArray objectAtIndex:i]] )
                break ;
        }
        
        ChapterArray = [[NSMutableArray alloc] init ] ;
        ChapterArray = [pDataBase getChapterList:(int)i+1];
        if ( [ChapterArray count] == 0 )
            NSLog(@"ChapterArray에 잘들어갔음");
        
        [chapterTable reloadData];
        SearchBar.text =@"";
        [SearchBar resignFirstResponder];
        
    }
    else if ( tableView == self.sideMenu ) // 슬라이딩 메뉴의 테이블뷰
    {
        NSString *s2 = [FirstArray objectAtIndex:indexPath.row] ;
        str = [str stringByAppendingString:s2] ;
        
        ChapterArray = [[NSMutableArray alloc] init ] ;
        ChapterArray = [pDataBase getChapterList:(int)indexPath.row+1];
        if ( [ChapterArray count] == 0 )
            NSLog(@"ChapterArray에 잘들어갔음");
        
        [chapterTable reloadData];
    }
    
    // ------------------------------------------------------------
    
    if ( indexPath.section == 0 && tableView != self.chapterTable ) {
        
        testingText.text = str ;
        
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
