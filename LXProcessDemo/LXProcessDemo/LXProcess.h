//
//  LXProcess.h
//  LXProcessDemo
//
//  Created by Xu小波 on 2020/5/1.
//  Copyright © 2020 Xu小波. All rights reserved.
//
//流程：支持将任务(封装的固定式的行为/强耦合或关联页面/强关联行为)串接，以达到代码整合和区域数据回调的目的

#import <Foundation/Foundation.h>

typedef id(^LXProcessMiddleHandle)(id para);
typedef void(^LXProcessEndHandle)(id backInfos);
typedef void(^LXProcessTaskDoing)(id para);

@class LXProcessItem;
@class LXProcessTaskItem;
@interface LXProcess : NSObject

+ (instancetype)share;

/// 启动流程 - 必需：processIdentity / task.taskDoing
/// @param processItem 流程实例
/// @param parameter 启动参数（任务中运用的参数）
- (void)begin:(LXProcessItem *)processItem parameter:(id)parameter;

/// 流程中间件 - 将返回对应函数返回值
/// @param processIdentity 流程id
/// @param middleKey 中间件key
/// @param yieldAction 中间件提交动作 - 以key响应middleHandles中的函数
- (id)middleware:(NSString *)processIdentity middleKey:(NSString *)middleKey yield:(id(^)(void)) yieldAction;

/// 结束流程
/// @param processIdentity 流程id
/// @param yieldAction 结束流程提交动作 - 响应endProcessHandle函数
- (void)end:(NSString *)processIdentity yield:(id(^)(void)) yieldAction;

/// 获取流程参数
/// @param processIdentity 流程id
- (id)parameterOfProcess:(NSString *)processIdentity;

@end

@interface LXProcessItem : NSObject

/// 流程标志
@property (nonatomic,   copy) NSString *processIdentity;

/// 流程名称
@property (nonatomic,   copy) NSString *processName;

/// 流程中所包含的任务
@property (nonatomic, strong) LXProcessTaskItem *task;

/// 流程所需的参数
@property (nonatomic, strong) id parameter;

/// 流程中间件的key与执行函数
@property (nonatomic, strong) NSDictionary<NSString *,LXProcessMiddleHandle> *middleHandles;

/// 流程结束执行函数
@property (nonatomic,   copy) LXProcessEndHandle endProcessHandle;

@end

@interface LXProcessTaskItem : NSObject

/// 任务key
@property (nonatomic,   copy) NSString *taskKey;

/// 任务名称
@property (nonatomic,   copy) NSString *taskName;

/// 任务参数
@property (nonatomic, strong) id parameter;

/// 任务启动函数
@property (nonatomic,   copy) LXProcessTaskDoing taskDoing;

@end

