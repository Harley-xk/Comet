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
    public class func customizeAppearenceColorWith(barTint: UIColor, foreground: UIColor) {
        
        self.appearance().barTintColor = barTint
        self.appearance().tintColor = foreground
        self.appearance().textColor = foreground
    }
    
    /// 设置导航栏的文字颜色
    public var textColor: UIColor? {
        get {
            return self.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
        }
        set {
            var attributes = self.titleTextAttributes ?? [NSAttributedStringKey : Any]()
            attributes[NSAttributedStringKey.foregroundColor] = newValue
            self.titleTextAttributes = attributes
        }
    }
    
    /// 设置导航栏标题的字体
    public var titleFont: UIFont? {
        get {
            return self.titleTextAttributes?[NSAttributedStringKey.font] as? UIFont
        }
        set {
            var attributes = self.titleTextAttributes ?? [NSAttributedStringKey : Any]()
            attributes[NSAttributedStringKey.font] = newValue
            self.titleTextAttributes = attributes
        }
    }
}
