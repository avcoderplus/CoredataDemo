//
//  CoreDataManager.h
//  CoredateClass16
//
//  Created by dllo on 15/9/26.
//  Copyright © 2015年 刘志强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataManager : NSObject



+ (CoreDataManager *)shareManager;

//数据管理器
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//存储模板（数据模型器）
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

//持久存储助理 （连接器）
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//保存
- (void)saveContext;
//获取应用程序本地路径
- (NSURL *)applicationDocumentsDirectory;



@end
