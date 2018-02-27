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

class Task: TaskProtocol {
    
    func cancel() {
        
    }
}

let task = Task()
obj.record(task: task)

let color = UIColor(hex: "0xaaddff")

let action = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)

let now = Date()

TimeZone(identifier: "Asia/Shanghai")

now.add(.day(1)).weekday

let date2 = now.set(.hour(0))
date2.string()
date2.unit(.era)

now.withoutTime.string()
date2.withoutTime

now.weekday

let nextMonth = Date() + .month(1)
let yestoday = now - .day(1)

let duration = DateInterval(start: date2, end: now).duration

let even = (-4).isEven
print()


//Utils.call("17768061343")
