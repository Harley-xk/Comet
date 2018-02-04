//
//  TaskCenter.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/2.
//

import Foundation

/**
 * 任务中心是网络框架的主要控制器，是网络任务的调度中心
 * 所有网络任务都需要提交到任务中心来派发，任务中心负责提供网络任务执行的环境配置等信息
 **/

open class TaskCenter {
    
    /// 核心任务中心，一般情况下直接使用核心任务中心即可执行所有任务，不需要额外创建新的对象
    public class var main: TaskCenter {
        return sharedMainTaskCenter
    }

    /// 默认的目标服务器，这个属性是必须的，一般在 App 启动后需要创建目标服务器实例并给 main task center 赋值。
    /// 如果开启了网络请求并且没有给 TaskCenter 设置默认服务器，会造成 App Crash ！
    public var server: Server!
    
    // MARK: - Initialize
    static let sharedMainTaskCenter = TaskCenter()

    init() {
        
    }
    
    /// 返回默认的中间件：<控制台日志(Debug only)><参数处理><模型解析>等通用组件，也可以自定中间件并覆盖设置
    public lazy var defaultTaskMiddleWares: [TaskMiddleWare] = {
        var middlewares: [TaskMiddleWare] = [
            
        ]
        #if DEBUG
            /// DEBUG 模式下打印请求数据
            middlewares.append(LoggingMiddleWare())
        #endif
        return middlewares
    }()
}


