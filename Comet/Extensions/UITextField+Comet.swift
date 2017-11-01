//
//  UITextField+Comet.swift
//  Comet
//
//  Created by Harley on 2016/11/8.
//
//

import Foundation

public extension UITextField {
    
    public func setPlaceholderColor(_ color: UIColor) {
        
        if let string = self.placeholder {
            if !string.isEmpty {
                let attributedString = NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor : color])
                self.attributedPlaceholder = attributedString
            }
        } else if let string = self.attributedPlaceholder {
            if string.length > 0 {
                let attributedString = NSMutableAttributedString(attributedString: string)
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSMakeRange(0, string.length))
                self.attributedPlaceholder = attributedString
            }
        }
    }    
}
