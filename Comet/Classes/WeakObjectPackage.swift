//
//  WeakObjectBox.swift
//  Comet
//
//  Created by Harley-xk on 2019/9/3.
//

import Foundation

public struct WeakObjectBox<T: AnyObject> {
    
    private weak var innerValue: T?
    
    init(value: T) {
        self.innerValue = value
    }
    
    func unboxed() -> T? {
        return innerValue
    }
}

/// 弱引用对象池，添加的对象不会被强引用
open class WeakObjectsPool<T: AnyObject> {
    
    private var packages: [WeakObjectBox<T>] = []
    
    public init() {}
    
    /// 添加一个对象
    open func addObject(_ object: T) {
        packages.append(WeakObjectBox(value: object))
    }
    
    /// 释放空盒子，建议数据量大时在合适的时机调用该方法
    open func clean() {
        packages = packages.compactMap { $0.unboxed() == nil ? nil : $0 }
    }
    
    /// 获取所有存活的对象数组
    open var aliveObjects: [T] {
        return packages.compactMap { $0.unboxed() }
    }
}
