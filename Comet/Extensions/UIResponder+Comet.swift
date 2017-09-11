//
//  UIResponder+Comet.swift
//  Comet
//
//  Created by Harley on 2016/11/8.
//
//

import Foundation

public extension UIResponder {
    
    /// 解除任何可能存在的第一响应者
    @discardableResult public class func resignAnyFirstResponder() -> Bool {
        return UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    /// 用于在 IB 中指定移除第一响应者事件
    @IBAction public func autoResignFirstResponder() {
        resignFirstResponder()
    }
    
    /// 用于在 IB 中指定第一响应者事件
    @IBAction public func autoBecomFirstResponder() {
        becomeFirstResponder()
    }
    
}

