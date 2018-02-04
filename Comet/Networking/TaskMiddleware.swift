//
//  TaskMiddleware.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/2.
//

import Foundation

public enum TaskMiddleWareState {
    /// 在任务即将发送到目标服务器之前调用，可以在这里给任务添加一些通用参数、header等
    case willStart
    /// 在任务完成后调用，框架自身会默认注册中间件用于数据解析等逻辑
    case didFihished
    /// 在任务被取消后调用
    case didCanceled
}

/**
 * 处理任务数据的中间件，用于提供自定义的网络任务的数据处理
 * 网络任务在特定的逻辑阶段会调用注册的中间件并执行其代码
 **/
public protocol TaskMiddleWare {
    
    /// 中间件执行的优先级，优先级最高的最先被调用。任务执行的不同的阶段可以指定不同的优先级
    /// 相同优先级的执行顺序由注册的先后顺序决定
    func priority(for state: TaskMiddleWareState) -> Int
    
    /// 任务状态发生改变时，注册的中间件都会收到通知，可以进行中间处理
    func task(_ task: Task, stateChangedTo state: TaskMiddleWareState)
}


/**
 * 用于请求日志打印的中间件，DEBUG 模式下会默认注册给所有请求
 **/
class LoggingMiddleWare: TaskMiddleWare {
    
    func priority(for state: TaskMiddleWareState) -> Int {
        switch state {
        /// 请求开始时的优先级最低，以保证打印日志时所有参数都已经设置完毕
        case .willStart: return 0
        
        /// 请求结束时的优先级最高，此时请求的状态和参数还未被修改，以保证打印最原始的响应数据
        case .didFihished: fallthrough
        case .didCanceled: return 999
        }
    }
    
    func task(_ task: Task, stateChangedTo state: TaskMiddleWareState) {
        switch state {
        case .willStart: taskWillStart(task)
        case .didFihished: taskDidFinished(task)
        case .didCanceled: taskDidCanceled(task)
        }
    }

    func taskWillStart(_ task: Task) {
        #if DEBUG
            let date = Date().string(format: "yyyy-MM-dd HH:mm:ss.SSS")
            print()
            print("TaskStarted: ", date, "-+-+-+-+-+-+-+-+-+->")
            print("       Host: ", task.targetServer.path)
            print("        Api: ", task.method.rawValue, task.apiName)
            print("     Header: ", task.headers)
            print("     Params: ", task.parameters)
            print()
        #endif
    }
    
    func taskDidFinished(_ task: Task) {
        let date = Date().string(format: "yyyy-MM-dd HH:mm:ss.SSS")
        print()
        print("TaskFinished: ", date, "------------------->")
        print("        Host: ", task.targetServer.path)
        print("         Api: ", task.method.rawValue, task.apiName)
        print("      Status: ", task.dataResponse?.response?.statusCode ?? -1)

        if case let .success(value)? = task.dataResponse?.result {
            var data: Data?
            var isJson = false
            if let json = try? JSONSerialization.jsonObject(with: value, options: .allowFragments), let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                data = jsonData
                isJson = true
            }
            let string = String(data: data ?? value, encoding: .utf8)
            print("    Response: ", isJson ? "<JSON> " : "<String> ", value.count, "bytes\n")
            print(string ?? "<null>")
        } else if case let .failure(error)? = task.dataResponse?.result {
            print("       Error: ", error.localizedDescription)
        } else {
            print("Unknown Response!")
        }
        print()
    }
    
    func taskDidCanceled(_ task: Task) {
        let date = Date().string(format: "yyyy-MM-dd HH:mm:ss.SSS")
        print()
        print("TaskCanceled: ", date, "-+-+-+-+-+-+-+-+-+->")
        print("        Host: ", task.targetServer.path)
        print("         Api: ", task.method.rawValue, task.apiName)
    }
}

