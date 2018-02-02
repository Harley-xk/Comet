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

open class Task {
    
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
    public var responseData: DataResponse<Data>?
    
    /// 初始化网络任务类
    ///
    /// - Parameters:
    ///   - method: 网络请求的方法类型：get、post 等
    ///   - api: api 接口名称
    ///   - params: 参数列表
    init(method: Method = .get, api: String, params: [String: Any] = [:]) {
        self.method = method
        self.apiName = api
        self.parameters = params
    }
    
    private var af_request: Alamofire.DataRequest?
}

extension Task: Excutable {
    
    public func start() {
        af_request = request(targetServer.path + apiName, method: method, parameters: parameters, encoding: paramEncoding, headers: headers)
        af_request?.responseData(completionHandler: { (resp) in
            
        })
    }
    
    public func cancel() {
        af_request?.cancel()
    }
}

