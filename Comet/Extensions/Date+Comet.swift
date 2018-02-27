//
//  Date+Comet.swift
//  Comet
//
//  Created by Harley on 2016/11/9.
//
//

import Foundation

public extension Date {
    
    /// 日期单元
    public struct DateUnit {
        var component: Calendar.Component
        var value: Int
        public static func year(_ value: Int) -> DateUnit { return DateUnit(component: .year, value: value) }
        public static func month(_ value: Int) -> DateUnit { return DateUnit(component: .month, value: value) }
        public static func day(_ value: Int) -> DateUnit { return DateUnit(component: .day, value: value) }
        public static func hour(_ value: Int) -> DateUnit { return DateUnit(component: .hour, value: value) }
        public static func minute(_ value: Int) -> DateUnit { return DateUnit(component: .minute, value: value) }
        public static func second(_ value: Int) -> DateUnit { return DateUnit(component: .second, value: value) }
    }
    
    /// 从日期字符串创建日期对象
    public init?(string: String, format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = TimeZone.current) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        
        if let date = formatter.date(from: string) {
            self = date
        }else {
            return nil
        }
    }
    
    /// 将日期转换为指定格式的字符串
    public func string(format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = TimeZone.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
    
    /// 转换为年月日的字符串
    public func dateString() -> String {
        return string(format: "yyyy-MM-dd")
    }

    /// 日期计算，返回当前日期加上指定单位值之后的日期，会自动进位或减位
    /// 返回计算后的新日期
    public func add(_ unit: DateUnit) -> Date {
        
        let calendar = Calendar.current
        var components = calendar.dateComponents(Set(Calendar.Component.dateAndTime), from: self)
        components.timeZone = TimeZone.current
        
        if let oriValue = components.value(for: unit.component) {
            components.setValue(oriValue + unit.value, for: unit.component)
        }
        let date = calendar.date(from: components)
        return date ?? self
    }
    
    /// 将指定单位设置为指定的值，返回修改后的新日期
    /// 如果设置的值大于当前单位的最大值或者小于最小值，会自动进位或减位
    public func set(_ unit: DateUnit) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents(Set(Calendar.Component.dateAndTime), from: self)
        components.timeZone = TimeZone.current
        components.setValue(unit.value, for: unit.component)

        let date = calendar.date(from: components)
        return date ?? self
    }
    
    /// 忽略精确时间（时／分／秒）的日期
    public var withoutTime: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.timeZone = TimeZone.current

        let date = calendar.date(from: components)
        return date ?? self
    }

    /// 某个单位的值
    public func unit(_ unit: Calendar.Component) -> Int {
        let calendar = Calendar.current
        var components = calendar.dateComponents([unit], from: self)
        components.timeZone = TimeZone.current
        return components.value(for: unit) ?? 0
    }
    
    /// 周几，周日为0
    public var weekday: Int {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.weekday], from: self)
        components.timeZone = TimeZone.current
        return (components.weekday ?? 1) - 1
    }
    
    // 两个日期相隔的分钟数
    public func minutesSince(_ date: Date) -> Double {
        let timeInterval = timeIntervalSince(date)
        let minute = timeInterval / 60
        return minute
    }
    
    // 两个日期相隔的小时数
    public func hoursSince(_ date: Date) -> Double {
        let minute = minutesSince(date)
        return minute / 60
    }
    
    /// 两个日期相隔的天数
    ///
    /// - Parameters:
    ///   - date: 与当前日期比较的日期
    ///   - withoutTime: 是否忽略精确的时分秒，可以启用该属性来比较两个日期的物理天数（即昨天、前天等）
    /// - Returns: 天数
    public func daysSince(_ date: Date, withoutTime: Bool = false) -> Double {
        var date1 = self
        var date2 = date
        if withoutTime {
            date1 = self.withoutTime
            date2 = date.withoutTime
        }
        let hours = date1.hoursSince(date2)
        return hours / 24
    }
    
    
    /// 判断两个日期是否在同一天内
    public func isSameDay(as date: Date?) -> Bool {
        guard let date = date else {
            return false
        }
        let days = daysSince(date, withoutTime: true)
        return days == 0
    }
}

public func +(lhs: Date, rhs: Date.DateUnit) -> Date {
    return lhs.add(rhs)
}

public func -(lhs: Date, rhs: Date.DateUnit) -> Date {
    var r = rhs
    r.value = -rhs.value
    return lhs.add(r)
}

public extension TimeZone {
    
    /// 中国时区(东8区)
    public static var china: TimeZone {
        return TimeZone(identifier: "Asia/Shanghai")!
    }
    
    // UTC 0 时区
    public static var zero: TimeZone {
        return TimeZone(abbreviation: "UTC")!
    }
    
}

public extension Calendar.Component {
    public static var date: [Calendar.Component] {
        return [.year, .month, .day]
    }
    public static var time: [Calendar.Component] {
        return [.hour, .minute, .second]
    }
    public static var dateAndTime: [Calendar.Component] {
        return [.year, .month, .day, .hour, .minute, .second]
    }
}


public extension Locale {
    
    /// 中国地区
    public static var china: Locale {
        return Locale(identifier: "zh_Hans_CN")
    }
    
    /// 美国地区
    public static var usa: Locale {
        return Locale(identifier: "es_US")
    }
}


