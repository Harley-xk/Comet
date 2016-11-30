//
//  UINavigationBar+Comet.swift
//  Comet
//
//  Created by Harley on 2016/11/8.
//
//

import Foundation

public extension UINavigationBar {
    
    /// 定义导航栏的全局颜色
    open class func customizeAppearenceColorWith(barTint: UIColor, foreground: UIColor) {
        
        self.appearance().barTintColor = barTint
        self.appearance().tintColor = foreground
        self.appearance().textColor = foreground
    }
    
    /// 设置导航栏的文字颜色
    open var textColor: UIColor? {
        get {
            return self.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
        }
        set {
            var attributes = self.titleTextAttributes ?? [String : Any]()
            attributes[NSForegroundColorAttributeName] = newValue
            self.titleTextAttributes = attributes
        }
    }
    
    /// 设置导航栏标题的字体
    open var titleFont: UIFont? {
        get {
            return self.titleTextAttributes?[NSFontAttributeName] as? UIFont
        }
        set {
            var attributes = self.titleTextAttributes ?? [String : Any]()
            attributes[NSFontAttributeName] = newValue
            self.titleTextAttributes = attributes
        }
    }
}
