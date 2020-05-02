//
//  LXProcess.m
//  LXProcessDemo
//
//  Created by Xu小波 on 2020/5/1.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "LXProcess.h"

@interface LXProcess ()

@property (nonatomic, strong) NSMutableDictionary *processes;

@end

@implementation LXProcess

+ (instancetype)share;{
    
    static LXProcess *process = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        process = [[LXProcess alloc]init];
    });
    
    return process;
}

- (NSMutableDictionary *)processes {
    
    if (!_processes) {
        
        _processes = [NSMutableDictionary dictionary];
    }
    return _processes;
}

/// 启动流程 - 必需：processIdentity / task.taskDoing
/// @param processItem 流程实例
/// @param parameter 启动参数（任务中运用的参数）
- (void)begin:(LXProcessItem *)processItem parameter:(id)parameter;{
    
    if (processItem.processIdentity) {
        
        if (parameter) {
            
            processItem.parameter = parameter;
        }
        if (processItem.task.taskDoing) {
            
            processItem.task.taskDoing(processItem.task.parameter);
            
            [self.processes setValue:processItem forKey:processItem.processIdentity];
        }
    }
}

/// 流程中间件 - 将返回对应函数返回值
/// @param processIdentity 流程id
/// @param middleKey 中间件key
/// @param yieldAction 中间件提交动作 - 以key响应middleHandles中的函数
- (id)middleware:(NSString *)processIdentity middleKey:(NSString *)middleKey yield:(id(^)(void)) yieldAction;{
    
    LXProcessItem *processItem = [self.processes valueForKey:processIdentity];
    
//    if (!processItem) return nil;
    
    LXProcessMiddleHandle middleHandle = [processItem.middleHandles valueForKey:middleKey];
    
    if (!middleHandle) return nil;
    
    return middleHandle(yieldAction());;
}

/// 结束流程
/// @param processIdentity 流程id
/// @param yieldAction 结束流程提交动作 - 响应endProcessHandle函数
- (void)end:(NSString *)processIdentity yield:(id(^)(void)) yieldAction;{
    
    LXProcessItem *processItem = [self.processes valueForKey:processIdentity];
    
   if (!processItem.endProcessHandle) return;
    
    processItem.endProcessHandle(yieldAction());
    
    [self.processes removeObjectForKey:processIdentity];
}

/// 获取流程参数
/// @param processIdentity 流程id
- (id)parameterOfProcess:(NSString *)processIdentity;{
    
    LXProcessItem *processItem = [self.processes valueForKey:processIdentity];
    
    return processItem.parameter;
}

@end

@implementation LXProcessItem

- (void)setParameter:(id)parameter {
    _parameter = parameter;
    
    _task.parameter = parameter;
}

- (void)setTask:(LXProcessTaskItem *)task {
    _task = task;
    
    if (_parameter) {
        _task.parameter = _parameter;
    }
}

@end

@implementation LXProcessTaskItem

@end
