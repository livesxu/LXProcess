//
//  OneViewController.m
//  LXProcessDemo
//
//  Created by Xu小波 on 2020/5/2.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "OneViewController.h"
#import "LXProcess.h"
#import "TwoViewController.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = [[LXProcess share] parameterOfProcess:@"process"];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 setTitle:@"插入事件One" forState:UIControlStateNormal];
    
    [btn1 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)btnAction {
    
    NSString *middleHandleBack = [[LXProcess share]middleware:@"process" middleKey:@"one" yield:^id{
        
        return @"事件11";
    }];
    
    NSLog(@"%@",middleHandleBack);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.navigationController pushViewController:[[TwoViewController alloc]init] animated:YES];
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
