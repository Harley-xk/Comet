//
//  String+Comet.swift
//  Comet
//
//  Created by Harley on 2016/11/8.
//
//

import UIKit

// MARK: - Bridge
public extension String {
    
    /// 返回桥接版的 NSString
    var ns: NSString {
        return self as NSString
    }
}

// MARK: - Urils
public extension String {
    /// 给空值提供默认替换值, 如果 string 为空字符串，则使用指定的默认值替换
    ///
    /// - Parameter value: 指定用来替换的值
    func emptyDefault(_ value: String) -> String {
        return self.isEmpty ? value : self
    }
    
    /// 判断 String 是否不为空
    var notEmpty: Bool {
        return !isEmpty
    }
}

// MARK: - 拼音

public extension String {
    
    /// 拼音的类型
    enum PinyinType {
        case normal         // 默认类型，不带声调
        case withTone       // 带声调的拼音
        case firstLetter    // 拼音首字母
    }
    
    func pinyin(_ type: PinyinType = .normal) -> String {
        switch type {
        case .normal:
            return normalPinyin()
        case .withTone:
            return pinyinWithTone()
        case .firstLetter:
            return pinyinFirstLetter()
        }
    }
    
    private func pinyinWithTone() -> String {
        //转换为带声调的拼音
        let nameRef = CFStringCreateMutableCopy(nil, 0, self as CFString)
        CFStringTransform(nameRef, nil, kCFStringTransformMandarinLatin, false)
        return nameRef! as String
    }
    
    private func normalPinyin() -> String {
        //去除声调
        let nameRef = CFStringCreateMutableCopy(nil, 0, self as CFString)
        CFStringTransform(nameRef, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(nameRef, nil, kCFStringTransformStripDiacritics, false)
        return nameRef! as String
    }
        
    private func pinyinFirstLetter() -> String {
        let pinyinString = pinyin() as NSString
        return pinyinString.substring(to: 1)
    }
}

// MARK: - Base64
public extension String {
    
    var base64Decode: String? {
        
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    var base64Encode: String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
}

// MARK: - RegEx
public extension String {
    /// 常用正则表达式
    // 邮箱
    var regex_email: String {
        return "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
    }
    
    // 电话号码
    var regex_phone: String {
        return "^(([+])\\d{1,4})*(\\d{3,4})*\\d{7,8}(\\d{1,4})*$"
    }
    
    // 手机号码
    var regex_mobile: String {
        return "^(([+])\\d{1,4})*1[0-9][0-9]\\d{8}$"
    }

    /// 判断是否匹配正则表达式
    func match(regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// 判断字符串是否是邮箱
    var isEmail: Bool {
        return self.match(regex: regex_email)
    }
    
    /// 判断是否是电话号码
    var isPhone: Bool {
        return self.match(regex: regex_phone)
    }

    /// 判断是否是手机号码
    var isMobile: Bool {
        return self.match(regex: regex_mobile)
    }
    
    /// 同时验证电话和手机
    var isPhoneOrMobile: Bool {
        return isPhone || isMobile
    }
}

// MARK: - Bounding Rect
public extension String {
        
    /// 计算字符串在指定高度下的宽度值
    /// - Parameters:
    ///   - height: 指定的字符串高度
    ///   - font: 字符串使用的字体
    ///   - options: 字符串绘制选项
    ///   - attributes: 字符串富文本属性，如果 attributes 中指定了 font，则忽略前面的 font 参数
    func limitedWidth(
        to height: CGFloat,
        font: UIFont,
        options: NSStringDrawingOptions = .preset,
        attributes: [NSAttributedString.Key : Any]? = nil
    ) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        return self.limitedSize(to: size, font: font, options: options, attributes: attributes).width
    }
    
    /// 计算字符串在指定宽度下的高度值
    /// - Parameters:
    ///   - width: 指定的字符串宽度
    ///   - font: 字符串使用的字体
    ///   - options: 字符串绘制选项
    ///   - attributes: 字符串富文本属性，如果 attributes 中指定了 font，则忽略前面的 font 参数
    func limitedHeight(
        to width: CGFloat,
        font: UIFont,
        options: NSStringDrawingOptions = .preset,
        attributes: [NSAttributedString.Key : Any]? = nil
    ) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return self.limitedSize(to: size, font: font, options: options, attributes: attributes).height
    }
    
    // 字符串尺寸计算，封装了 boundingRect 方法
    private func limitedSize(
        to size: CGSize,
        font: UIFont,
        options: NSStringDrawingOptions,
        attributes: [NSAttributedString.Key : Any]? = nil
    ) -> CGSize {
        let string = self as NSString
        var attributes = attributes ?? [:]
        if attributes[.font] == nil {
            attributes[.font] = font
        }
        let rect = string.boundingRect(
            with: size,
            options: options,
            attributes: attributes,
            context: nil
        )
        return rect.size
    }
}

public extension NSStringDrawingOptions {
    // 预设选项
    static let preset: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesDeviceMetrics, .usesFontLeading]
}
