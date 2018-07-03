//
//  WindowPresentable.swift
//  Common UI
//
//  Created by Harley.xk on 2017/4/27.
//  Copyright © 2017年 Harley-xk. All rights reserved.
//

import UIKit

enum WindowPresentableAnimation {
    case transform
    case fade
    case none
}

protocol WindowPresentable: class {
    var window: UIWindow? { get set }
    var windowRoot: UIViewController { get }
    var animationDuration: TimeInterval { get }
}

/// 全局变量，保存当前所有已弹出 Window 的 Level
var GloableWindowLevels = [UIWindowLevelNormal]

extension WindowPresentable where Self: UIViewController {
    
    // MARK: - Show Hide
    func showWindow(animation: WindowPresentableAnimation = .transform, completion: (() -> Void)? = nil) {
        let screenFrame = UIScreen.main.bounds
        window = UIWindow(frame: screenFrame)
        window?.windowLevel = windowLevel
            
        window?.rootViewController = self.windowRoot
        window?.makeKeyAndVisible()
        
        GloableWindowLevels.append(windowLevel)
        
        if animation == .transform {
            var beginFrame = screenFrame
            beginFrame.origin.y = beginFrame.size.height
            window?.frame = beginFrame
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.window?.frame = screenFrame
            }, completion: { (finished) in
                completion?()
            })
        } else if animation == .fade {
            self.window?.alpha = 0
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.window?.alpha = 1
            }, completion: { (finished) in
                completion?()
            })
        } else {
            completion?()
        }
    }
    
    func hideWindow(animation: WindowPresentableAnimation = .fade, completion: (() -> Void)? = nil) {
        let block = {
            self.setNeedsStatusBarAppearanceUpdate()
            self.window?.rootViewController = nil
            self.window?.resignKey()
            self.window = nil
            GloableWindowLevels.removeLast()
        }
        
        if animation == .transform {
            var endFrame = UIScreen.main.bounds
            endFrame.origin.y = endFrame.size.height
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.window?.frame = endFrame
            }, completion: { (finished) in
                block()
                completion?()
            })
        } else if animation == .fade {
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.window?.alpha = 0
            }, completion: { (finished) in
                block()
                completion?()
            })
        } else {
            block()
            completion?()
        }
    }
    
    var windowRoot: UIViewController {
        return self
    }

    var animationDuration: TimeInterval {
        return 0.2
    }
    
    var windowLevel: UIWindowLevel {
        if let level = GloableWindowLevels.last {
            return level + 1
        }
        return UIWindowLevelNormal + 1
    }
}
