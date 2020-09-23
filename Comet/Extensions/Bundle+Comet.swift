//
//  Bundle+Comet.swift
//  Comet
//
//  Created by Harley-xk on 2020/9/23.
//

import Foundation

extension Bundle {
    
    /// Bundle Identifier
    open var identifier: String {
        return infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }
    
    /// Bundle 版本号
    open var version: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
    }

    /// Bundle Build 号
    open var build: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }
    
    /// 获取 Bundle 中指定名称资源的路径
    ///
    /// - Parameters:
    ///   - name: 资源名称
    /// - Returns: 返回资源路径, 资源不存在时返回空
    func resource(_ name: String) -> Path? {
        let path = name as NSString
        let pathExtension = path.pathExtension
        let nameWithoutExtension = pathExtension.isEmpty ? name : path.deletingPathExtension
        if let url = url(forResource: nameWithoutExtension, withExtension: pathExtension) {
            return Path(url)
        }
        return nil
    }
    
}
