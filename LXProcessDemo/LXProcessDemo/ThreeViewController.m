//
//  ThreeViewController.m
//  LXProcessDemo
//
//  Created by Xu小波 on 2020/5/2.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "ThreeViewController.h"
#import "LXProcess.h"
@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.title = [[LXProcess share] parameterOfProcess:@"process"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[LXProcess share] end:@"process" yield:^id{
        
        return @"结束流程";
    }];
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
