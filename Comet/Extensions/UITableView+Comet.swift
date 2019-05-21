//
//  UITableView+Comet.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/12.
//

import Foundation
import UIKit

extension UITableView {
    
    /// 快速注册可重用的 cell，使用 cell 的类名作为 ReuseIdentifier
    public func register<Cell: UITableViewCell>(cell classType: Cell.Type) {
        let identifier = String(describing: Cell.self)
        register(classType, forCellReuseIdentifier: identifier)
    }
    
    /// 快速创建可重用的 cell，使用 cell 的类名作为 ReuseIdentifier
    public func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
    }
    
    /// 快速注册可重用的 HeaderFooterView，使用 HeaderFooterView 的类名作为 ReuseIdentifier
    public func register<View: UITableViewHeaderFooterView>(headerFooterView classType: View.Type) {
        let identifier = String(describing: View.self)
        register(classType, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /// 快速创建可重用的 HeaderFooterView，使用 HeaderFooterView 的类名作为 ReuseIdentifier
    public func dequeueReusableHeaderFooterView<View: UITableViewHeaderFooterView>() -> View {
        let identifier = String(describing: View.self)
        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! View
    }
}
