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
    class var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    /// 根据名称从 MainBundle 中创建 Storyboard
    convenience init(_ name: String) {
        self.init(name: name, bundle: nil)
    }
    
    /// 从 sb 创建视图控制器
    /// identifier 为空时默认使用类名
    func create<T: UIViewController>(identifier: String? = nil) -> T {
        let id = identifier ?? T.typeName
        return self.instantiateViewController(withIdentifier: id) as! T
    }
    
    /// 创建当前 sb 入口视图控制器的实例
    func createInitial<T: UIViewController>() -> T {
        return instantiateInitialViewController() as! T
    }
}

public extension UIViewController {

    /// 从 Storyboard 实例化视图控制器
    ///
    /// - Parameters:
    ///   - storyboard: 视图控制器所在的故事版，默认为 main
    ///   - identifier: 视图控制器在 Storyboard 中的 identifier，不传默认为类名
    /// - Description:
    ///   建议对 UIStoryboard 扩展来获得常用的故事版对象，参见 UIStoryboard.main 的实现
    class func createFromStoryboard(_ storyboard: UIStoryboard = .main, identifier: String? = nil) -> Self {
        return storyboard.create(identifier: identifier ?? typeName)
    }
    
    /// 从 Storyboard 实例化入口视图控制器
    ///
    /// - Parameters:
    ///   - storyboard: 视图控制器所在的故事版，默认为 main
    class func createInitial(from storyboard: UIStoryboard = .main) -> Self {
        return storyboard.createInitial()
    }
}


public extension UIViewController {
    
    /// 从 Xib 文件创建视图控制器，nibName 为空时默认使用类名
    class func createFromXib(_ nibName: String? = nil, bundle: Bundle? = nil) -> Self {
        let name = nibName ?? typeName
        return self.init(nibName: name, bundle: bundle)
    }
}

public extension NSObject {
    /// 获取类名，不包含完整的模块名称
    class var typeName: String {
        return String(describing: self)
    }
}

