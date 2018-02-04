//
//  Task.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/2.
//

import Foundation
import Alamofire

/// 可执行任务的通用协议
public protocol Excutable: TaskProtocol {
    func start()
}

open class Task: Excutable {
    
//    /// 请求响应回调
//    public typealias ResponseHandler = (_ response: Response) -> ()
//    public var responseHandler: ResponseHandler?
    
    /// 请求的目标服务器，默认使用 TaskCenter 中配置的默认服务器，也可以另外指定
    public lazy var targetServer: Server = TaskCenter.main.server
    
    /// 请求方法，GET、POST等
    public typealias Method = Alamofire.HTTPMethod
    public var method: Method
    
    /// api 接口的名称
    public var apiName: String
    
    /// 请求头部域的自定义数据
    /// 注意：Alamofire 会根据情况自动添加一些通用字段
    public var headers: [String: String] = [:]
    
    /// 接口参数
    public var parameters: [String: Any]
    
    /// 请求参数编码方式，默认为 url-encoding
    public typealias ParamEncoding = Alamofire.ParameterEncoding
    public lazy var paramEncoding = URLEncoding()
    
    /// 请求的原始响应数据
    public private(set) var dataResponse: DataResponseFromAF?
    
    /// 任务处理的中间件，通过中间件可以实现对于网络请求的特殊自定义需求
    /// 默认情况下会装载在 TaskCenter 中指定的通用中间件
    public lazy var middlewares: [TaskMiddleWare] = TaskCenter.main.defaultTaskMiddleWares
    
    /// 初始化网络任务类
    ///
    /// - Parameters:
    ///   - method: 网络请求的方法类型：get、post 等
    ///   - api: api 接口名称
    ///   - params: 参数列表
    public init(method: Method = .get, api: String, params: [String: Any] = [:]) {
        self.method = method
        self.apiName = api
        self.parameters = params
    }
    
    /// Newworking 使用 Alamofire 管理网络请求
    private var af_request: Alamofire.DataRequest?

    // MARK: - Excutable
    
    public func start() {
        
        /// 通知中间件请求即将开始
        sendNotificationToMiddlewares(for: .willStart)
        
        /// 组装参数并执行请求
        af_request = request(targetServer.path + apiName, method: method, parameters: parameters, encoding: paramEncoding, headers: headers)
        af_request?.responseData(completionHandler: { (resp) in
            /// 请求完成，读取返回数据
            self.dataResponse = DataResponseFromAF(dataResponse: resp)
            /// 执行完成任务的逻辑
            self.finished()
        })
    }
    
    public func finished() {
        /// 通知中间件请求已完成
        self.sendNotificationToMiddlewares(for: .didFihished)
    }
    
    public func cancel() {
        af_request?.cancel()
        
        /// 通知中间件请求已取消
        self.sendNotificationToMiddlewares(for: .didFihished)
    }
}

extension Task {
    func sortedMiddlewares(for state: TaskMiddleWareState) -> [TaskMiddleWare] {
        return middlewares.sorted { (m1, m2) -> Bool in
            return m1.priority(for: state) > m2.priority(for: state)
        }
    }
    
    func sendNotificationToMiddlewares(for state: TaskMiddleWareState) {
        let sorted = sortedMiddlewares(for: state)
        sorted.forEach { (middleware) in
            middleware.task(self, stateChangedTo: state)
        }
    }
}

