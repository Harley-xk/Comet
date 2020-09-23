//
//  CometErrors.swift
//  Comet
//
//  Created by Harley-xk on 2020/9/23.
//

import Foundation

/// Comet 框架所有异常信息定义
enum CometError: Error {
    
    /// 设备不支持打电话
    case phoneCallNotSupported
    
    
    /// 未定义的错误
    case unknown
}

extension CometError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .phoneCallNotSupported: return "设备不支持拨打电话"
        default: return "未知错误"
        }
    }
}
