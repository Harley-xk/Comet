//: Playground - noun: a place where people can play

import UIKit
import Comet

var str = "Hello, playground"

let version = Utils.appVersion
Utils.appBuild

let model = Utils.deviceUUID

Utils.deviceModel

let path = Path.applicationSupport().resource("data.Sqlite").string

let obj = NSObject()

class Task: NSObject, TaskProtocol {
    
    func cancel() {
        
    }
}

let task = Task()
obj.record(task: task)

let color = UIColor(hex: "0xaaddff")

let action = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

let date = Date()

TimeZone(identifier: "Asia/Shanghai")

date.add(1, .day).weekday

let date2 = date.set(.hour, to: 0)
date2.string()
date2.unit(.day)

date.withoutTime.string()
date2.withoutTime

date.weekday

let duration = DateInterval(start: date2, end: date).duration




//Utils.call("17768061343")
