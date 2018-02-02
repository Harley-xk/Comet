//
//  UIScrollView+Comet.swift
//  Pods
//
//  Created by Harley on 2017/1/22.
//
//

import Foundation
import UIKit

public extension UIScrollView {
    
    /// 滚动到 ScrollView 顶部
    ///
    /// - Parameter animated: 是否显示动画，默认显示
    public func scrollToTop(animated: Bool = true) {
        let x = contentOffset.x + contentInset.left + contentInset.right
        let destination = CGRect(x: x, y: 0, width: 1, height: 1)
        scrollRectToVisible(destination, animated: animated)
    }
    
    /// 滚动到 ScrollView 底部
    ///
    /// - Parameter animated: 是否显示动画，默认显示
    public func scrollToBottom(animated: Bool = true) {
        let x = contentOffset.x + contentInset.left + contentInset.right
        let destination = CGRect(x: x, y: contentSize.height - 1, width: 1, height: 1)
        scrollRectToVisible(destination, animated: animated)
    }
    
    /// 滚动到 ScrollView 左边
    ///
    /// - Parameter animated: 是否显示动画，默认显示
    public func scrollToLeft(animated: Bool = true) {
        let y = contentOffset.y + contentInset.top + contentInset.bottom
        let destination = CGRect(x: 0, y: y, width: 1, height: 1)
        scrollRectToVisible(destination, animated: animated)
    }

    /// 滚动到 ScrollView 底部
    ///
    /// - Parameter animated: 是否显示动画，默认显示
    public func scrollToRight(animated: Bool = true) {
        let y = contentOffset.y + contentInset.top + contentInset.bottom
        let destination = CGRect(x: contentSize.width - 1, y: y, width: 1, height: 1)
        scrollRectToVisible(destination, animated: animated)
    }
}

