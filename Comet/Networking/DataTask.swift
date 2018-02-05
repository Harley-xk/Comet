//
//  DataTask.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/2.
//

import Foundation

public class DataTask<Model: Codable>: Task {
    
    public typealias ResponseHandler = (Response<Model>) -> Swift.Void
    public var responseHandler: ResponseHandler?
    
    public override func start() {
        super.start()
    }
    
    public override func finished() {
        super.finished()
        
        let response = Response<Model>(dataResponse: dataResponse)
        responseHandler?(response)
    }
}
