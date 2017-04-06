//
//  AppDelegate.m
//  CodeDemo
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 LYP. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self cleanFinderFiles:@"zhuanti"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)cleanFinderFiles:(NSString *)finder {
    // 获取沙盒目录
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *imageFilePath = [paths[0] stringByAppendingPathComponent:finder];
    NSString *fileFinder;
    fileFinder = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),finder];
    // 在指定目录下创建 "head" 文件夹
    //判断imageFilePath路径文件夹是否已存在，此处imageFilePath为需要新建的文件夹的绝对路径
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileFinder]) {
        //        return;
        //清空目录
        [[NSFileManager defaultManager] removeItemAtPath:fileFinder error:NULL];
        [[NSFileManager defaultManager] createDirectoryAtPath:fileFinder withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        //创建文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:fileFinder withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
