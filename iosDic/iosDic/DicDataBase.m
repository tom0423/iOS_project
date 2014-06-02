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
                        stringByAppendingPathComponent:@"test2.sqlite"];
    
    // 데이터베이스 연결
    if ( sqlite3_open([myPath UTF8String], tempDataBase ) != SQLITE_OK ) {
        *tempDataBase = nil ;
        return ;
    }
}



// N권 안의 chapter name 리스트들을 가져온다
- (NSMutableArray*)getChapterList:(int)bookNum
{
    NSString *pDName ;      // CName  : 파일명
    sqlite3 *pDataBase ;
    sqlite3_stmt *statement = nil ;
    
    ChapterListArray = [[NSMutableArray alloc] init ] ;
    
    // 데이터베이스 연결
    [self DataBaseConnection:&pDataBase] ;
    
    if( pDataBase == nil ) {
        NSLog(@"Error DB : '%s'",sqlite3_errmsg(pDataBase)) ;
        return NULL ;
    }
    
    // 검색 SQL
    NSString *querySQL = [NSString stringWithFormat:@"SELECT chName FROM Dictionary WHERE Book=\"%d\"", bookNum];
    const char *sql = [querySQL UTF8String];
    
    // SQL Text를 prepared statement로 변환
    if ( sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK ) {
        
        NSLog(@"Error DB : '%s'", sqlite3_errmsg(pDataBase)) ;
        sqlite3_close(pDataBase) ;
        pDataBase = nil ;
        return NULL ;
    }
    
    
    if ( ChapterListArray == nil ) {
        ChapterListArray = [[NSMutableArray alloc] init ] ;
    }
    
    // 객체에 등록
    if ( ChapterListArray != nil ) {
        [ChapterListArray removeAllObjects] ;
        
        // 쿼리를 실행
        while ( sqlite3_step(statement) == SQLITE_ROW ) {
            // 각 권에 대한 장 이름
            pDName = [[NSString alloc] initWithString:[NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 0)]];
            
            // 검색 결과를 Array 객체에 담습니다.
            //[ChapterListArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:pDName, @"ChapterName", nil]];
            [ChapterListArray addObject:pDName];
        }
        
    }
    
    sqlite3_reset(statement) ;
    sqlite3_finalize(statement) ;
    sqlite3_close(pDataBase) ;
    pDataBase = nil ;
    
    return ChapterListArray ;
    
}


// N권 N장안의 컨텐츠 리스트들 검색하여 컨텐츠 리스트 반환
- (NSMutableArray*) getContentsList:(int)bookNum:(int)chapterNum ;
{
    NSString *pCName ;      // CName  : 파일명
    //NSString *pCField ;     // CField : 파일내용
    //NSNumber *pCNum ;       // CNum   : 파일넘버 (몇번째 파일?)
    sqlite3 *pDataBase ;
    sqlite3_stmt *statement = nil ;
    
    ContentsListArray = [[NSMutableArray alloc] init ] ;
    
    // 데이터베이스 연결
    [self DataBaseConnection:&pDataBase] ;
    
    if( pDataBase == nil ) {
        NSLog(@"Error DB : '%s'",sqlite3_errmsg(pDataBase)) ;
        return NULL ;
    }
    
    // 검색 SQL
    NSString *querySQL = [NSString stringWithFormat:@"SELECT Contents.CName FROM Dictionary natural join Contents where Dictionary.Book = \"%d\" and Dictionary.Chapter = \"%d\" order by CNum", bookNum, chapterNum];
    //NSString *querySQL = @"SELECT CName FROM Contents";
    const char *sql = [querySQL UTF8String];
    
    // SQL Text를 prepared statement로 변환
    if ( sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK ) {
        
        NSLog(@"Error DB : '%s'", sqlite3_errmsg(pDataBase)) ;
        sqlite3_close(pDataBase) ;
        pDataBase = nil ;
        return NULL ;
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
            pCName = [[NSString alloc] initWithString:[NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 0)]];
            
            // 검색 결과를 Array 객체에 담습니다.
            [ContentsListArray addObject:pCName];
        }
        
    }
    
    sqlite3_reset(statement) ;
    sqlite3_finalize(statement) ;
    sqlite3_close(pDataBase) ;
    pDataBase = nil ;
    
    return ContentsListArray ;
    
}



// N권 N장안의 컨텐츠 리스트들 검색하여 URL 리스트 반환
- (NSMutableArray*) getContentsURLList:(int)bookNum:(int)chapterNum ;
{
    //NSString *pCName ;      // CName  : 파일명
    NSString *pCField ;     // CField : 파일내용
    //NSNumber *pCNum ;       // CNum   : 파일넘버 (몇번째 파일?)
    sqlite3 *pDataBase ;
    sqlite3_stmt *statement = nil ;
    
    ContentsURLListArray = [[NSMutableArray alloc] init ] ;
    
    // 데이터베이스 연결
    [self DataBaseConnection:&pDataBase] ;
    
    if( pDataBase == nil ) {
        NSLog(@"Error DB : '%s'",sqlite3_errmsg(pDataBase)) ;
        return NULL ;
    }
    
    // 검색 SQL
    
    NSString *querySQL = [NSString stringWithFormat:@"SELECT Contents.CField FROM Dictionary natural join Contents where Dictionary.Book = \"%d\" and Dictionary.Chapter = \"%d\" order by CNum", bookNum, chapterNum];
    const char *sql = [querySQL UTF8String];
    
    // SQL Text를 prepared statement로 변환
    if ( sqlite3_prepare_v2(pDataBase, sql, -1, &statement, NULL) != SQLITE_OK ) {
        
        NSLog(@"Error DB : '%s'", sqlite3_errmsg(pDataBase)) ;
        sqlite3_close(pDataBase) ;
        pDataBase = nil ;
        return NULL ;
    }
    
    
    if ( ContentsURLListArray == nil ) {
        ContentsURLListArray = [[NSMutableArray alloc] init ] ;
    }
    
    // 객체에 등록
    if ( ContentsURLListArray != nil ) {
        [ContentsURLListArray removeAllObjects] ;
        
        // 쿼리를 실행
        while ( sqlite3_step(statement) == SQLITE_ROW ) {
            // 각 권에 대한 장 이름
            pCField = [[NSString alloc] initWithString:[NSString stringWithUTF8String:(char*) sqlite3_column_text(statement, 0)]];
            
            // 검색 결과를 Array 객체에 담습니다.
            [ContentsURLListArray addObject:pCField];
        }
        
    }
    
    sqlite3_reset(statement) ;
    sqlite3_finalize(statement) ;
    sqlite3_close(pDataBase) ;
    pDataBase = nil ;
    
    return ContentsURLListArray;
    
}


@end
