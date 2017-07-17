//
//  PinyinIndexer.swift
//  Comet
//
//  Created by Harley.xk on 16/11/8.
//
//

import UIKit

/// 索引器对象协议，用来告知索引器需要转换为拼音的属性
public protocol PinyinIndexable {
    var valueToPinyin: String { get }
}

/// 拼音索引器，将指定的对象数组按照指定属性进行拼音首字母排序并创建索引
open class PinyinIndexer<T: PinyinIndexable> {

    private var objectList: [T]
    private var propertyName: String
    
    /// 处理完毕的对象数组，按索引分组
    open var indexedObjects = [[T]]()
    /// 处理完毕的索引数组（拼音首字母）
    open var indexedTitles = [String]()
    
    /// 创建索引器实例
    ///
    /// - Parameters:
    ///   - objects: 需要索引的对象数组
    ///   - property: 索引依据的属性键值，属性必须为 String 类型
    public init(objects: [T], property: String) {
        objectList = objects
        propertyName = property
        
        self.indexObjects()
    }
    
    private func indexObjects() {

        // 按索引分组
        let theCollation = UILocalizedIndexedCollation.current()
        let indexArray = [PinyinIndex<T>]();
        
        for object in self.objectList {
            let index = PinyinIndex(fromObject: object, property: propertyName)
            let section = theCollation.section(for: index, collationStringSelector: #selector(PinyinIndex<T>.pinyin))
            index.sectionNumber = section
        }
        
        let sortedIndexArray = indexArray.sorted { (index1, index2) -> Bool in
            return index1.name > index2.name
        }
        
        let sectionCount = theCollation.sectionTitles.count
        
        for i in 0 ..< sectionCount {
            var sectionArray = [T]()
            for j in 0 ..< sortedIndexArray.count {
                let index = sortedIndexArray[j]
                if index.sectionNumber == i {
                    sectionArray.append(index.object)
                }
            }
            if sectionArray.count > 0 {
                indexedObjects.append(sectionArray)
                indexedTitles.append(theCollation.sectionTitles[i])
            }
        }
    }
}

class PinyinIndex<T: PinyinIndexable> {
    
    var object: T
    var name: String
    var sectionNumber: Int = 0
    
    init(fromObject obj: T, property: String) {
        object = obj
        name = obj.valueToPinyin
    }
    
    @objc func pinyin() -> String {
        return name.pinyin(.firstLetter)
    }
}
