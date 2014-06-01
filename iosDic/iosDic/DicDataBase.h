//
//  RecordDataBase.h
//  iosDic
//
//  Created by PC6 on 2014. 5. 31..
//  Copyright (c) 2014년 PC6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DicDataBase : NSObject
{
    NSMutableArray *ContentsListArray ; // 검색된 게시글의 내용을 저장하는 Array 객체
    NSMutableArray *ContentsURLListArray ; // 검색된 게시글의 URL을 저장하는 Array 객체
    NSMutableArray *ChapterListArray;   // chapter의 이름을 저장하는 Array 객체
}

- (void) DataBaseConnection:(sqlite3 **)tempDataBase ;  // 데이터베이스 연결

- (NSMutableArray*) getContentsList:(int)bookNum:(int)chapterNum ;      // N권 N장안의 컨텐츠 리스트들 검색하여 컨텐츠 리스트 반환
- (NSMutableArray*) getContentsURLList:(int)bookNum:(int)chapterNum ;   // N권 N장안의 컨텐츠 리스트들 검색하여 URL 리스트 반환
- (NSMutableArray*) getChapterList:(int)bookNum ;                       // N권 안의 chapter name 리스트들 검색

@property(nonatomic, retain) NSMutableArray *ContentsListArray ;
@property(nonatomic, retain) NSMutableArray *ContentsURLListArray ;
@property(nonatomic, retain) NSMutableArray *ChapterListArray ;

@end
