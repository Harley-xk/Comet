//
//  UINavigationBar+Comet.swift
//  Comet
//
//  Created by Harley on 2016/11/8.
//
//

import Foundation

public extension UINavigationBar {
    
    public func setTextColor(_ color: UIColor) {
        var attributes = self.titleTextAttributes ?? [String : Any]()
        attributes[NSForegroundColorAttributeName] = color
        self.titleTextAttributes = attributes
    }
    
    public func setTitleFont(_ font: UIFont) {
        var attributes = self.titleTextAttributes ?? [String : Any]()
        attributes[NSFontAttributeName] = font
        self.titleTextAttributes = attributes
    }
}
