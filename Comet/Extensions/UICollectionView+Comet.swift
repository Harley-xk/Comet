//
//  UICollectionView+Comet.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/12.
//

import Foundation
import UIKit

extension UICollectionView {
    
    /// 快速注册可复用的 cell，使用类型名称作为 ReuseIdentifier
    public func register<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let identifier = String(describing: Cell.self)
        register(cell, forCellWithReuseIdentifier: identifier)
    }
    
    /// 快速创建可重用的 cell，使用 cell 的类名作为 ReuseIdentifier
    public func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }
    
    /// 快速注册可复用的 SupplementaryView，使用类型名称作为 ReuseIdentifier
    public func registerSupplementaryView<V: UIView>(_ type: V.Type = V.self, ofKind kind: String) {
        let identifier = String(describing: V.self)
        register(V.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    /// 快速获取可复用的 SupplementaryView，使用类型名称作为 ReuseIdentifier
    public func dequeueSupplementaryView<V: UIView>(_ type: V.Type = V.self, ofKind kind: String, for indexPath: IndexPath) -> V {
        let identifier = String(describing: V.self)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as! V
    }
}
