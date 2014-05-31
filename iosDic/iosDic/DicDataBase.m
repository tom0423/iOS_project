//
//  RecordDataBase.m
//  iosDic
//
//  Created by PC6 on 2014. 5. 31..
//  Copyright (c) 2014년 PC6. All rights reserved.
//

#import "DicDataBase.h"

@implementation DicDataBase

// 데이터베이스 연결
- (void)DataBaseConnection:(sqlite3 **)tempDataBase
{
    // Documents 폴더 위치를 구함
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) ;
    NSString *documentDirectory = [paths objectAtIndex:0] ;
    NSString *myPath = [documentDirectory
                        stringByAppendingPathComponent:@"Dictionary.sqlite"];
    
    // 데이터베이스 연결
    if ( sqlite3_open([myPath UTF8String], tempDataBase ) != SQLITE_OK ) {
        *tempDataBase = nil ;
        return ;
    }
}

// Contents 테이블에서 원하는 권, 장에대한 모든 컨텐츠 리스트들을 가져온다
- (void)getContentsList
{
    NSString *pCName ;      // CName  : 파일명
    NSString *pCField ;     // CField : 파일내용
    NSNumber *pCNum ;       // CNum   : 파일넘버 (몇번째 파일?)
    
    sqlite3 *pDataBase ;
    sqlite3_stmt *statement = nil ;
    
    [self DataBaseConnection:&pDataBase] ;  // 데이터베이스 연결
    if( pDataBase == nil ) {
        NSLog(@"Error DB : '%s'",sqlite3_errmsg(pDataBase)) ;
        return ;
    }
    
   
    // 검색 SQL
 /*
    int bookNum = 1;
    const char *sql = "SELECT chName FROM Dictionary where Book = bookNum" ;
    
    // SQL Text를 prepared statement로 변환
    if ( sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK ) {
        
        NSLog(@"Error DB : '%s'", sqlite3_errmsg(pDataBase)) ;
        sqlite3_close(pDataBase) ;
        pDataBase = nil ;
        return ;
    }
    
   */
    if ( ContentsListArray == nil ) {
        ContentsListArray = [[NSMutableArray alloc] init ] ;
    }
    
    // 객체에 등록
    if ( ContentsListArray != nil ) {
        [ContentsListArray removeAllObjects] ;
        
        // 쿼리를 실행
        while ( sqlite3_step(statement) == SQLITE_ROW ) {
            // p279
        }
        
    }
    
    sqlite3_reset(statement) ;
    sqlite3_finalize(statement) ;
    sqlite3_close(pDataBase) ;
    pDataBase = nil ;
    
}

// N권 안의 chapter name 리스트들을 가져온다
- (void)getChapterList
{
    NSString *pDName ;      // CName  : 파일명
    
    sqlite3 *pDataBase ;
    sqlite3_stmt *statement = nil ;
    
    [self DataBaseConnection:&pDataBase] ;  // 데이터베이스 연결
    if( pDataBase == nil ) {
        NSLog(@"Error DB : '%s'",sqlite3_errmsg(pDataBase)) ;
        return ;
    }
    
    
    // 검색 SQL
    int bookNum = 1;
    const char *sql = "SELECT chName FROM Dictionary where Book = bookNum" ;
    
    // SQL Text를 prepared statement로 변환
    if ( sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK ) {
        
        NSLog(@"Error DB : '%s'", sqlite3_errmsg(pDataBase)) ;
        sqlite3_close(pDataBase) ;
        pDataBase = nil ;
        return ;
    }
    
    
    if ( ContentsListArray == nil ) {
        ContentsListArray = [[NSMutableArray alloc] init ] ;
    }
    
    // 객체에 등록
    if ( ContentsListArray != nil ) {
        [ContentsListArray removeAllObjects] ;
        
        // 쿼리를 실행
        while ( sqlite3_step(statement) == SQLITE_ROW ) {
            // 각 권에 대한 장 이름
            pDName = [[NSString alloc] initWithString:[NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 0)]];
            
            // 검색 결과를 Array 객체에 담습니다.
            [ChapterListArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:pDName, @"ChapterName", nil]];
        }
        
    }
    
    sqlite3_reset(statement) ;
    sqlite3_finalize(statement) ;
    sqlite3_close(pDataBase) ;
    pDataBase = nil ;
    
}


@end
