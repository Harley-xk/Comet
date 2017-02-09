//
//  UINavigationController+Comet.swift
//  Pods
//
//  Created by Harley on 2017/2/9.
//
//

import Foundation
import UIKit

extension UINavigationController {    
    /// 替换当前导航控制器栈顶的视图
    open func replaceTop(with viewController: UIViewController, animated: Bool = true) {
        var vcs = self.viewControllers
        vcs.removeLast()
        vcs.append(viewController)
        setViewControllers(vcs, animated: animated)
    }
}
