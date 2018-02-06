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

/// 请求的返回数据模型必须实现 ModelDecodable 协议，这样可以由中间件调用以实例化模型
public protocol ModelDecodable {
    static func createModel(from data: Data) throws -> Self?
}

/// 为 Decodable 协议自动实现 ModelDecodable
public extension ModelDecodable where Self: Decodable {
    static func createModel(from data: Data) throws -> Self? {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}

/// 为 String 类型自动实现 ModelDecodable
extension String: ModelDecodable {
    public static func createModel(from data: Data) throws -> String? {
        return String(data: data, encoding: .utf8)
    }
}

/**
 * 网络请求的基础类，基于 Alamofire，负责执行实际网络请求以及管理其它相关逻辑
 **/
open class Task<Model: ModelDecodable>: Excutable {
    
    /// 网络任务的状态，主要用于告知中间件当前网络任务执行的阶段
    public enum State {
        /// 初始状态，任务刚创建完毕
        /// 中间件不会收到该状态的通知
        case created
        /// 在任务即将发送到目标服务器之前调用，可以在这里给任务添加一些通用参数、header等
        case willStart
        /// 即将重新发送新的网络任务, 此时不应该再次处理请求参数
        case willRestart
        /// 正在等待响应
        case waitingResponse
        /// 在任务完成后调用，框架自身会默认注册中间件用于数据解析等逻辑
        case didFihished
        /// 在任务被取消后调用
        case didCanceled
    }
    
    /// 网络任务的状态，状态发生改变时会向注册的中间件发送通知
    public var state: State = .created {
        didSet {
            if state != oldValue {
                sendNotificationToMiddlewares()
            }
        }
    }
    
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
    
    /// 请求的原始响应数据，请求结束后从 Alamofire 的响应数据中读取
    public private(set) var dataResponse: DataResponseFromAF?
    
    /// 请求响应回调
    public typealias ResponseHandler = (Response<Model>) -> Swift.Void
    public var responseHandler: ResponseHandler?
    
    /// 请求响应的结果，由中间件处理后设置。默认提供基于 Codable 的 JSON 解析中间件
    public var response: Response<Model>?
    
    /// 任务处理的中间件，通过中间件可以实现对于网络请求的特殊自定义需求
    /// 默认情况下会装载在 TaskCenter 中指定的通用中间件
    public lazy var middlewares: [TaskMiddleware] = TaskCenter.main.defaultTaskMiddlewares
    
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
        state = .willStart
        sendTask()
    }
    
    public func restart() {
        state = .willRestart
        sendTask()
    }
    
    public func finished() {
        state = .didFihished
        
        if let resp = response {
            responseHandler?(resp)
        }
    }
    
    public func cancel() {
        if state != .waitingResponse {
            return
        }
        state = .didCanceled
        af_request?.cancel()
    }
    
    public func sendTask() {
        /// 组装参数并执行请求
        af_request = request(targetServer.path + apiName, method: method, parameters: parameters, encoding: paramEncoding, headers: headers)
        
        /// 发起请求，通过闭包保持自身不被释放，直到请求结束
        af_request?.responseData(completionHandler: { (resp) in
            /// 主动取消的任务不做任何处理
            if self.state == .didCanceled {
                return
            }
            /// 请求完成，读取返回数据
            self.dataResponse = DataResponseFromAF(dataResponse: resp)
            /// 执行完成任务的逻辑
            self.finished()
        })
        
        /// 状态修改为等待响应
        state = .waitingResponse
    }
}

// MARK: - Middlewares

extension Task {
    
    /// 中间件按照优先级排序
    func sortedMiddlewares(for state: State) -> [TaskMiddleware] {
        return middlewares.sorted { (m1, m2) -> Bool in
            return m1.priority(for: state) > m2.priority(for: state)
        }
    }
    
    /// 向中间件发送状态改变的通知
    func sendNotificationToMiddlewares() {
        let sorted = sortedMiddlewares(for: state)
        sorted.forEach { (middleware) in
            middleware.task(self, stateChangedTo: state)
        }
    }
}

