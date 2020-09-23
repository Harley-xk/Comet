//
//  Grouper.swift
//  Comet
//
//  Created by Harley-xk on 2019/4/11.
//

import Foundation

/// 集合分组后的数据实体
public class Group<Element, T: Hashable> {
    public var index: T
    public var elements: [Element]
    public init(index: T, elements: [Element]) {
        self.index = index
        self.elements = elements
    }
}

/// 集合分组器，保存分组结果
open class CollectionGroups<C: Collection, Key: Hashable> {
        
    /// 分组后的数组集合
    public private(set) var results: [Key: [C.Element]] = [:]
    
    /// 对集合按照制定的属性进行分组
    public init(group collection: C, by property: KeyPath<C.Element, Key>) {
        results = Dictionary(grouping: collection, by: { $0[keyPath: property] })
    }
    
    /// 对集合按照制定的属性进行分组
    public init(group collection: C, by rule: (C.Element) -> Key) {
        results = Dictionary(grouping: collection, by: rule)
    }
    
    public lazy var groups: [Group<C.Element, Key>] = {
        return results.map {
            Group(index: $0, elements: $1)
        }
    }()
}

public extension Array {
    
    func grouped<T: Hashable>(by property: KeyPath<Element, T>) -> CollectionGroups<[Element], T> {
        return CollectionGroups(group: self, by: property)
    }
    
    func grouped<T: Hashable>(by rule: (Element) -> T) -> CollectionGroups<[Element], T> {
        return CollectionGroups(group: self, by: rule)
    }
}
