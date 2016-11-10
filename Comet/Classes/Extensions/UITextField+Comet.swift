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
            if string.characters.count > 0 {
                let attributedString = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName : color])
                self.attributedPlaceholder = attributedString
            }
        } else if let string = self.attributedPlaceholder {
            if string.length > 0 {
                var attributedString = NSMutableAttributedString(attributedString: string)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, string.length))
                self.attributedPlaceholder = attributedString
            }
        }
    }    
}
