//
//  UIDevice+Comet.swift
//  Comet
//
//  Created by Harley.xk on 16/6/27.
//
//

import Foundation
import UIKit

/// 定义一个空函数的别名，方便使用
public typealias EmptyHandler = () -> ()

/**
 扩展 UIDevice，以快速获取一些属性
 */
public extension UIDevice {
    
    /// 设备唯一识别码
    var uuid: String {
        return identifierForVendor?.uuidString ?? ""
    }
        
    /// 设备详细型号，例如：iPhone 1,2 etc...
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 发起电话呼叫
    ///
    /// - Parameters:
    ///   - phone: 被叫方的电话号码
    ///   - withConfirm: 是否弹出确认提示
    /// - throws: 不支持电话功能时抛出 CometError.phoneCallNotSupported 异常
    func makePhoneCall(to phone: String, withConfirm: Bool = true) throws {
        let typeString = withConfirm ? "tel" : "telprompt"
        guard let callURL = URL(string: typeString + "://" + phone),
            UIApplication.shared.canOpenURL(callURL) else {
            throw CometError.phoneCallNotSupported
        }
        UIApplication.shared.open(callURL)
    }
    
    /// 检测设备是否越狱
    /// - Note: 通过检测是否存在 cydia 应用以及超越沙盒的访问权限来判断
    func jailbroken() -> Bool {
        
        // 存在 cydia 应用
        if let cydiaURL = URL(string: "cydia://package/com.example.package"),
            UIApplication.shared.canOpenURL(cydiaURL) {
            return true
        }

        // 越狱后可能存在或者访问到的路径
        let jailbrokenAccessable = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/var/lib/cydia",
            "/User/Applications/",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        
        for path in jailbrokenAccessable {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        return false
    }
}
