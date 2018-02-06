//
//  JSONResponseMiddleware.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/6.
//

import UIKit

class CodableJsonMiddleware: TaskMiddleware {
    
    func task<Model>(_ task: Task<Model>, stateChangedTo state: Task<Model>.State) {
        guard state == .didFihished else {
            return
        }
        
        var statusCode = -1
        var message = "No Message"
        var succeed = false
        
        guard let dataResponse = task.dataResponse else {
            statusCode = -1
            message = CODE_ERROR_MESSAGE[statusCode] ?? "Unknown Error"
            return
        }
        
        if case .failure(let error) = dataResponse.result {
            let nsError = error as NSError
            statusCode = nsError.code
            message = nsError.localizedDescription
        } else {
            statusCode = dataResponse.response?.statusCode ?? -1
            message = CODE_ERROR_MESSAGE[statusCode] ?? "Unknown Error"
        }
        
        succeed = (statusCode >= 200 && statusCode < 300)
        
        guard succeed, let jsonData = dataResponse.value else {
            task.response = Response<Model>(succeed: succeed, statusCode: statusCode, message: message, model: nil)
            return
        }
        
        guard Model.self is Decodable else {
            task.response = Response<Model>(succeed: false, statusCode: -1, message: "Model is not Decodable", model: nil)
            return
        }

        var model: Model?
        do {
            model = try Model.createModel(from: jsonData)
        } catch {
            succeed = false
            message = error.localizedDescription
        }

        task.response = Response<Model>(succeed: succeed, statusCode: statusCode, message: message, model: model)
    }
}

