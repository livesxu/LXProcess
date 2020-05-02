//
//  TwoViewController.m
//  LXProcessDemo
//
//  Created by Xu小波 on 2020/5/2.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "TwoViewController.h"
#import "LXProcess.h"
#import "ThreeViewController.h"
@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = [[LXProcess share] parameterOfProcess:@"process"];

    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 setTitle:@"插入事件Two" forState:UIControlStateNormal];
        
    [btn1 addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
}

- (void)btnAction {
        
    [[LXProcess share]middleware:@"process" middleKey:@"two" yield:^id{
            
        return @"事件22";
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.navigationController pushViewController:[[ThreeViewController alloc]init] animated:YES];
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
