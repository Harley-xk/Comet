//
//  TaskMiddleware.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/2.
//

import Foundation

/**
 * 处理任务数据的中间件，用于提供自定义的网络任务的数据处理
 * 网络任务在特定的逻辑阶段会调用注册的中间件并执行其代码
 **/
public protocol TaskMiddleware {
    
    /// 中间件执行的优先级，优先级最高的最先被调用。任务执行的不同的阶段可以指定不同的优先级
    /// 相同优先级的执行顺序由注册的先后顺序决定，默认：0
    func priority<Model>(for state: Task<Model>.State) -> Int
    
    /// 任务状态发生改变时，注册的中间件都会收到通知，可以进行中间处理
    /// willStart: 在任务即将发送到目标服务器之前调用，可以在这里给任务添加一些通用参数、header等
    /// didFihished: 在任务完成后调用，框架自身会默认注册中间件用于数据解析等逻辑
    /// didCanceled: 在任务被取消后调用
    func task<Model>(_ task: Task<Model>, stateChangedTo state: Task<Model>.State)
}

extension TaskMiddleware {
    func priority<Model>(for state: Task<Model>.State) -> Int { return 0 }
}

