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

public class Response<Model: Codable> {
    
    /// 请求是否成功
    public var succeed = false
    
    /// 请求响应的状态码，一般情况下是 http 状态码，请求没有发送成功时会使用特定的状态码
    public var statusCode = -1
    
    /// 请求状态描述信息
    public var message = ""
    
    /// 序列化后的数据模型对象
    public var model: Model?
    
    init(dataResponse: DataResponseFromAF?) {
        
        guard let resp = dataResponse else {
            statusCode = -1
            message = CODE_ERROR_MESSAGE[statusCode] ?? "Unknown Error"
            return
        }
        
        if case .failure(let error) = resp.result {
            let nsError = error as NSError
            statusCode = nsError.code
            message = nsError.localizedDescription
        } else {
            statusCode = resp.response?.statusCode ?? -1
            message = CODE_ERROR_MESSAGE[statusCode] ?? "Unknown Error"
        }

        succeed = (statusCode >= 200 && statusCode < 300)
        
        guard succeed, let jsonData = resp.value else {
            return
        }
        
        do {
            model = try JSONDecoder().decode(Model.self, from: jsonData)
        } catch {
            succeed = false
            message = error.localizedDescription
        }
    }
}
