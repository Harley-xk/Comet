//
//  Numbers+Comet.swift
//  Comet
//
//  Created by Harley.xk on 2017/8/18.
//

import Foundation
import CoreGraphics

// Convert String to Numbers
public extension String {

    /// convert string to int
    /// - Returns: returns 0 if failed
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    /// convert string to double
    /// - Returns: 0 if failed
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
    
    /// convert string to float
    /// - Returns: 0 if failed
    func toFloat() -> Float {
        return Float(self) ?? 0
    }
    
    /// convert string to float
    /// - Returns: 0 if failed
    func toCGFloat() -> CGFloat {
        return CGFloat(toDouble())
    }
}

// Convert Float to String
public extension Float {
    
    // 返回指定小数位数的字符串
    func toString(decimals: Int) -> String {
        return String(format: "%.\(decimals)f", self)
    }
    
    // 返回指定格式的字符串
    func toString(format: String) -> String {
        return String(format: format, self)
    }
}

// Convert Double to String
public extension Double {
    // 返回指定小数位数的字符串
    func toString(decimals: Int) -> String {
        return String(format: "%.\(decimals)f", self)
    }
    // 返回指定格式的字符串
    func toString(format: String) -> String {
        return String(format: format, self)
    }
}

public extension Int {
    
    // 返回指定格式的字符串
    func toString(format: String? = nil) -> String {
        if let format = format {
            return String(format: format, self)
        } else {
            return "\(self)"
        }
    }
    
    /// 返回当前值是否是偶数
    var isEven: Bool {
        return self % 2 == 0
    }
}
