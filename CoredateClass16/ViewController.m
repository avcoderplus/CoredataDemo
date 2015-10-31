//
//  ViewController.m
//  CoredateClass16
//
//
//  Created by dllo on 15/9/26.
//  Copyright © 2015年 刘志强. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "Student.h"
@interface ViewController ()
@property (nonatomic, strong)CoreDataManager *coreDataManger;
@property (nonatomic, strong)NSArray *reultArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.coreDataManger =[CoreDataManager shareManager];
    NSLog(@"storeURL:%@",[self.coreDataManger applicationDocumentsDirectory]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//增加
- (IBAction)add:(UIButton *)sender
{
    //参数1.实体名称
    //参数2.通过谁获取实体描述（数据管理器）
 //   NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.coreDataManger.managedObjectContext];
    //参数1.通过一个实体对象来初始化
    //参数2.交给谁去管理（数据管理器）
//    Student *stu = [[Student alloc]initWithEntity:entity insertIntoManagedObjectContext:self.coreDataManger.managedObjectContext];
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.coreDataManger.managedObjectContext];
    
    //@相当于oc 对 c 的扩展
    stu.name = @"刘";
    stu.age = @100;
    stu.sex = @"男";
    
    [self.coreDataManger saveContext];
    

    
    
}

/*Core Data 是将数据本地存储对象化了，相当于直接将对像存入本地*/

//查找
- (IBAction)find:(UIButton *)sender
{
    //获取数据的请求
    //参数：实体名称
 //   NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    //谓词(断言) 条件查找
  //  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age > 99 "];
  //  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age > 99 OR name = '刘' "];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS '刘' "];
//    request.predicate = predicate;
    
    // 向数据管理器发送获取数据的请求
//    NSArray *resultArray = [self.coreDataManger.managedObjectContext executeFetchRequest:request error:nil];
    
 //   for (Student *stu in resultArray) {
//        NSLog(@"%@, %@",stu.name,stu.age);
 //   }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.coreDataManger.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS '刘' "];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    //1.按什么排序
    //2.是否升序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManger.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.reultArray = fetchedObjects;
    if (fetchedObjects == nil) {
      
        NSLog(@"error:%@",error);
    }
    else
    {
        for (Student *stu in fetchedObjects)
        {
            NSLog(@"%@, %@ ,%@",stu.name,stu.age,stu.sex);
        }
    }
    
}
//更新
- (IBAction)update:(UIButton *)sender
{
    for (Student *stu in self.reultArray) {
        if ([stu.age isEqual:@99]) {
            stu.age = @98;
        }
    }
    [self.coreDataManger saveContext];
}
//删除
- (IBAction)deledate:(UIButton *)sender
{
    for (Student *stu in self.reultArray) {
        if ([stu.age isEqual:@100]) {
            [self.coreDataManger.managedObjectContext deleteObject:stu];
        }
    }
    [self.coreDataManger saveContext];

}
@end
