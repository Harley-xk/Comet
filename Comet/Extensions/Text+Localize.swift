//
//  Text+Localize.swift
//  Comet
//
//  Created by Harley.xk on 2017/5/8.
//
//

import Foundation
import UIKit

extension UILabel {
    @IBInspectable var localizedKey: String? {
        set {
            guard let newValue = newValue else { return }
            text = NSLocalizedString(newValue, comment: "")
        }
        get { return text }
    }
}

extension UIButton {
    @IBInspectable var localizedKey: String? {
        set {
            guard let newValue = newValue else { return }
            setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
        }
        get { return titleLabel?.text }
    }
}

extension UITextField {
    @IBInspectable var localizedKey: String? {
        set {
            guard let newValue = newValue else { return }
            placeholder = NSLocalizedString(newValue, comment: "")
        }
        get { return placeholder }
    }
}

extension UINavigationItem {
    @IBInspectable var localizedKey: String? {
        set {
            guard let newValue = newValue else { return }
            title = NSLocalizedString(newValue, comment: "")
        }
        get { return title }
    }
}

extension UIBarItem {
    @IBInspectable var localizedKey: String? {
        set {
            guard let newValue = newValue else { return }
            title = NSLocalizedString(newValue, comment: "")
        }
        get { return title }
    }
}
