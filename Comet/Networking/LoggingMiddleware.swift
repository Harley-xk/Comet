//
//  LoggingMiddleware.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/5.
//

import UIKit


/**
 * 用于请求日志打印的中间件，DEBUG 模式下会默认注册给所有请求
 **/
class LoggingMiddleware: TaskMiddleware {
    
    func priority<Model>(for state: Task<Model>.State) -> Int {
        switch state {
        /// 请求开始时的优先级最低，以保证打印日志时所有参数都已经设置完毕
        case .willStart: return 0
            
        /// 请求结束时的优先级最高，此时请求的状态和参数还未被修改，以保证打印最原始的响应数据
        case .didFihished: fallthrough
        case .didCanceled: return 999
        default: return 0
        }
    }
    
    func task<Model>(_ task: Task<Model>, stateChangedTo state: Task<Model>.State) {
        switch state {
        case .willStart: taskWillStart(task)
        case .didFihished: taskDidFinished(task)
        case .didCanceled: taskDidCanceled(task)
        default: break
        }
    }
    
    
    func taskWillStart<Model>(_ task: Task<Model>) {
        let date = Date().string(format: "yyyy-MM-dd HH:mm:ss.SSS")
        print()
        print("TaskStarted: ", date, "-+-+-+-+-+-+-+-+-+->")
        print("       Host: ", task.targetServer.path)
        print("        Api: ", task.method.rawValue, task.apiName)
        print("     Header: ", task.headers)
        print("     Params: ", task.parameters)
        print()
    }
    
    func taskDidFinished<Model>(_ task: Task<Model>) {
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
    
    func taskDidCanceled<Model>(_ task: Task<Model>) {
        let date = Date().string(format: "yyyy-MM-dd HH:mm:ss.SSS")
        print()
        print("TaskCanceled: ", date, "-+-+-+-+-+-+-+-+-+->")
        print("        Host: ", task.targetServer.path)
        print("         Api: ", task.method.rawValue, task.apiName)
        print()
    }
}

