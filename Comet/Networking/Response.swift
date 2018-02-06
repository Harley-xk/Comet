//
//  Response.swift
//  Alamofire
//
//  Created by Harley.xk on 2018/2/5.
//

import UIKit

/**
 * 请求最终返回的结果，包含请求的状态、返回数据等.
 **/

public struct Response<Model> {
    
    /// 请求是否成功
    public let succeed: Bool
    
    /// 请求响应的状态码，一般情况下是 http 状态码，请求没有发送成功时会使用特定的状态码
    public let statusCode: Int
    
    /// 请求状态描述信息
    public let message: String
    
    /// 序列化后的数据模型对象
    public let model: Model?
}
