//
//  UIViewController+Comet.wwift
//  Comet
//
//  Created by Harley on 2016/11/8.
//
//

import Foundation
import UIKit

public extension UIStoryboard {
    
    /// 获取 Main Storyboard
    open class var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    /// 根据名称从 MainBundle 中创建 Storyboard
    open convenience init(_ name: String) {
        self.init(name: name, bundle: nil)
    }
    
    /// 从 sb 创建视图控制器
    /// identifier 为空时默认使用类名
    open func create<T: UIViewController>(identifier: String? = nil) -> T {
        let id = identifier ?? T.classNameWithoutModule
        return self.instantiateViewController(withIdentifier: id) as! T
    }
    
    /// 创建当前 sb 入口视图控制器的实例
    open var initial: UIViewController? {
        return instantiateInitialViewController()
    }
}

public extension UIViewController {
    
    /// 从 Storyboard 实例化视图控制器
    ///
    /// - Parameters:
    ///   - name: Storyboard 名称，不传默认为Main
    ///   - bunlde: Storyboard 所在的 Bundle 不传默认为 main bundle
    ///   - id: 视图控制器在 Storyboard 中的id，不传默认为类名
    open class func fromSB(_ name: String? = nil, bunlde: Bundle? = nil, id: String? = nil) -> Self {
        let bundle = bunlde ?? Bundle.main
        let sbName = name ?? "Main"
        let sb = UIStoryboard(name: sbName, bundle: bundle)
        let identifier = id ?? classNameWithoutModule
        return sb.create(identifier: identifier)
    }
}


public extension UIViewController {
    
    /// 从 Xib 文件创建视图控制器，nibName 为空时默认使用类名
    open class func fromXib(_ nibName: String? = nil, bundle: Bundle? = nil) {
        let name = nibName ?? classNameWithoutModule
        self.init(nibName: name, bundle: bundle)        
    }
}

public extension UIViewController {

    /**
     *  设置当前视图的导航条返回按钮标题
     *  @attention 只有使用默认返回按钮时有效
     */
    open var navigationBackTitle: String? {
        get {
            if let previous = self.previousNavigationContent {
                return previous.navigationItem.backBarButtonItem?.title
            }
            return nil
        }
        set {
            if let previous = self.previousNavigationContent {
                previous.navigationItem.backBarButtonItem = UIBarButtonItem(title: newValue, style: .plain, target: nil, action: nil)
            }
        }
    }
    
    /// 获取导航控制器栈中前一个视图控制器，不存在时返回空
    open var previousNavigationContent: UIViewController? {
        if let viewControllers = self.navigationController?.viewControllers,
            viewControllers.count > 2 {
            let index = viewControllers.count - 2
            return viewControllers[index]
        }
        return nil
    }
    
    /**
     *  设置导航控制器栈中下一个视图的返回按钮标题
     *  @attention 不会改变当前返回按钮的标题
     */
    open var nextNavigationBackTitle: String? {
        get {
            return self.navigationItem.backBarButtonItem?.title
        }
        set {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: newValue, style: .plain, target: nil, action: nil)
        }
    }
}

public extension NSObject {
    /// 获取去除了模块名称的类名
    internal class var classNameWithoutModule: String {
        var name = self.classForCoder().description()
        let compments = name.components(separatedBy: ".")
        return compments.last!
    }
}

