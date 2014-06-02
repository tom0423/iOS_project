//
//  AppDelegate.m
//  iosDic
//
//  Created by PC6 on 2014. 5. 7..
//  Copyright (c) 2014년 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 14/05/31 KimDB : DB 파일을 복사
    
    // 데이터베이스 파일복사
    [self CopyOfDataBaseIfNeeded] ;
    
//    [self.window addSubview:[UIViewController view]] ;
    [self.window makeKeyAndVisible];//?
    
    // Override point for customization after application launch.
    return YES;
}

// 14/05/31 KimDB : 번들에 있는 데이터베이스를 복사하는 메서드
- (BOOL)CopyOfDataBaseIfNeeded {
    
    // Documents 폴더 위치를 구함
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES ) ;
    NSString *documentDirectory = [paths objectAtIndex:0] ;
    
    // 데이터베이스 파일명 : Dictionary.sqlite
    NSString *myPath = [documentDirectory
                        stringByAppendingPathComponent:@"test2.sqlite"] ;
    
    NSFileManager *fileManager = [NSFileManager defaultManager] ;
    BOOL exist = [fileManager fileExistsAtPath:myPath] ;
    
    if ( exist ) {
        NSLog(@"DB가 존재합니다") ;
        return TRUE ;
    }
    
    // 파일이 없으면 리소스에서 파일을 복사
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]
                               stringByAppendingPathComponent:
                               @"test2.sqlite"] ;
    
    return [fileManager copyItemAtPath:defaultDBPath toPath:myPath error:nil] ;
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
