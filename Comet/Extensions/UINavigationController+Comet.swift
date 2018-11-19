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
    
    /// 简化 push 函数
    open func push(_ viewController: UIViewController, animated: Bool = true) {
        pushViewController(viewController, animated: animated)
    }
    
    /// 简化 pop 函数，且不强制要求接收返回值
    ///
    /// - Parameters:
    ///   - delay: 延迟出栈，用于某些需要先提示用户状态然后退出界面的场景，传 0 则立刻执行出栈动作
    ///   - animated: 是否显示出栈动画
    /// - Returns: 被出栈的视图控制器, 使用延迟出栈时固定返回 nil
    @discardableResult
    open func pop(delay: TimeInterval = 0, animated: Bool = true) -> UIViewController? {
        var poped: UIViewController? = nil
        let popAction = {
            poped = self.popViewController(animated: animated)
        }
        if delay > 0 {
            DispatchQueue.main.asyncAfter(delay: delay, execute: popAction)
        } else {
            popAction()
        }
        return poped
    }
}
