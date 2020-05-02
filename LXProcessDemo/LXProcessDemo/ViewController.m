//
//  ViewController.m
//  LXProcessDemo
//
//  Created by Xu小波 on 2020/5/2.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "ViewController.h"
#import "LXProcess.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSDictionary *tasksConfig;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf = self;
    
    LXProcessTaskItem *task1 = [[LXProcessTaskItem alloc]init];
    task1.taskKey = @"task1";
    task1.taskName = @"任务1";
    task1.taskDoing = ^(id para) {
        
        OneViewController *one = [[OneViewController alloc]init];
        [weakSelf.navigationController pushViewController:one animated:YES];
    };
    
    LXProcessTaskItem *task2 = [[LXProcessTaskItem alloc]init];
    task2.taskKey = @"task2";
    task2.taskName = @"任务2";
    task2.taskDoing = ^(id para) {
        
        TwoViewController *two = [[TwoViewController alloc]init];
        [weakSelf.navigationController pushViewController:two animated:YES];
    };
    
    LXProcessTaskItem *task3 = [[LXProcessTaskItem alloc]init];
    task3.taskKey = @"task3";
    task3.taskName = @"任务3";
    task3.taskDoing = ^(id para) {
        
        ThreeViewController *three = [[ThreeViewController alloc]init];
        [weakSelf.navigationController pushViewController:three animated:YES];
    };
    
    _tasksConfig = @{@"task1":task1,
                     @"task2":task2,
                     @"task3":task3,
    };
    
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"task1" forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    btn2.backgroundColor = [UIColor yellowColor];
    [btn2 setTitle:@"task2" forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    btn3.backgroundColor = [UIColor blueColor];
    [btn3 setTitle:@"task3" forState:UIControlStateNormal];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
}

- (void)btnAction:(UIButton *)btn {
    
    NSString *taskKey = [NSString stringWithFormat:@"task%d",(int)btn.tag];
    
    __weak typeof(self) weakSelf = self;
    
    LXProcessItem *processItem = [[LXProcessItem alloc]init];
    //当多个应用流程目的相同时可以将id置为相同，方便统一处理结果
    processItem.processIdentity = [NSString stringWithFormat:@"process"];
//    processItem.processIdentity = [NSString stringWithFormat:@"process%d",(int)btn.tag];
    processItem.processName = [NSString stringWithFormat:@"流程%d",(int)btn.tag];;
    processItem.task = _tasksConfig[taskKey];
    processItem.parameter = processItem.processName;
    
    //中间件预定义函数执行
    LXProcessMiddleHandle middleOne = (id) ^(id para) {
        
        NSLog(@"One插入事件携带参数 - %@",para);
        
        return @"已处理One插入事件";
    };
    LXProcessMiddleHandle middleTwo = (id) ^(id para) {
        
        NSLog(@"Two插入事件携带参数 - %@",para);
        
        return @"已处理Two插入事件";
    };
    processItem.middleHandles = @{
        @"one":middleOne,
        @"two":middleTwo,
    };
    processItem.endProcessHandle = ^(id backInfos) {
        
        NSLog(@"结束流程，数据 - %@",backInfos);
        [weakSelf.navigationController popToViewController:weakSelf animated:YES];
    };
    
    [[LXProcess share] begin:processItem parameter:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
