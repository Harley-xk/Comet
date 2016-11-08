# Harley.xk
iOS 项目的 Swift 基础库，提供大量常用组件、便利方法等。

基于 HKProjectBase 库，根据 Swift 的语法特性，重新实现了大部分的逻辑, 移除了部分不常用／不成熟的代码。

#### 移除
1. 移除 MD5 编码、RC4 加密等相关内容，需要时使用其他第三方库，推荐：[CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift), 更加成熟的加密框架，支持更广泛的加密协议;
