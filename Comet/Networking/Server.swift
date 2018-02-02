//
//  Server.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/2.
//

import Foundation

/**
 * 网络请求的服务器实例，用来抽象表示后端服务器的地址，网络请求需要依赖服务器实例来获知请求的目标地址
 * 一般情况下 App 只需要一个指定的服务器对象，特殊情况下也可以创建多个不同的 Server 对象来向不同的服务器发送请求
 **/

open class Server: Codable, Equatable {
    
    /// 与目标服务器通讯使用的协议，一般固定为 https，也可以是 http
    let scheme: String
    
    /// 目标服务器的主机地址，一般为特定域名或者 ip 地址
    let host: String
    
    /// 目标服务器开启的网络请求的端口号，可以留空，此时由目标服务器自行指定默认端口号
    let port: Int?
    
    /// 通过指定通讯协议、主机地址以及端口号来创建一个目标服务器实例
    init(scheme: String = "https", host: String, port: Int? = nil) {
        self.scheme = scheme
        self.host = host
        self.port = port
    }
    
    /// 服务器路径，用于拼接 api 地址
    lazy var path: String = {
        var path = host
        if scheme.contains("://") {
            path = "\(scheme)" + path
        } else {
            path = "\(scheme)://" + path
        }
        if let port = port {
            path += ":\(port)"
        }
        return path + "/"
    }()
    
    /// 判断两个服务器实例是否指向同一个目标服务器地址，不同端口号的同一个主机认为是不同的目标服务器
    public static func ==(lhs: Server, rhs: Server) -> Bool {
        return lhs.path == rhs.path
    }
}
