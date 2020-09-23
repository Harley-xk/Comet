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

    public typealias SortFunction = (C.Element, C.Element) -> Bool
    private var sortFunction: SortFunction?
    
    /// 分组后的数组集合
    public private(set) var results: [Key: [C.Element]] = [:]
    
    /// 对集合按照制定的属性进行分组
    public convenience init(
        group collection: C,
        by property: KeyPath<C.Element, Key>,
        sorted sort: SortFunction? = nil
    ) {
        self.init(group: collection, by: { $0[keyPath: property] }, sorted: sort)
    }
    
    /// 对集合按照制定的属性进行分组
    public init(
        group collection: C,
        by rule: (C.Element) -> Key,
        sorted sort: SortFunction? = nil
    ) {
        var array: [C.Element]
        if let s = sort {
            sortFunction = s
            array = collection.sorted(by: s)
        } else {
            array = Array(collection)
        }
        results = Dictionary(grouping: array, by: rule)
    }
    
    public lazy var sortedGroups: [Group<C.Element, Key>] = {
        var groups = results.map {
            Group(index: $0, elements: $1)
        }
        if let sort = sortFunction {
            groups = groups.sorted(by: { left, right in
                if left.elements.count <= 0 { return false }
                if right.elements.count <= 0 { return true }
                return sort(left.elements.first!, right.elements.first!)
            })
        }
        return groups
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
