//
//  DataTask.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/2.
//

import Foundation

public struct Response<Model: Codable> {

    public var data: Model?
}

public class DataTask<Model: Codable>: Task {
    public typealias ResponseHandler = (Response<Model>) -> Swift.Void
    public var responseHandler: ResponseHandler?
    
    public override func start() {
        super.start()
    }
    
}

public struct User: Codable {
    
}

public class AuthTask {

    public class func userInfo() -> DataTask<User> {
        return DataTask(api: "xxx")
    }
    
}

