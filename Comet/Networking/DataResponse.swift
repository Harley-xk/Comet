//
//  Response.swift
//  Comet
//
//  Created by Harley.xk on 2018/2/4.
//

import UIKit
import Alamofire

/**
 * ResponseData 等价于 Alamofire.DataResponse<Data>，重写该类型以实现继承
 **/

public class DataResponseFromAF {
    /// The URL request sent to the server.
    public let request: URLRequest?
    
    /// The server's response to the URL request.
    public let response: HTTPURLResponse?
    
    /// The result of response serialization.
    public let result: Result<Data>
    
    /// The timeline of the complete lifecycle of the request.
    public let timeline: Timeline
    
    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Data? { return result.value }
    
    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Error? { return result.error }

    public init(dataResponse: DataResponse<Data>)
    {
        self.request = dataResponse.request
        self.response = dataResponse.response
        self.result = dataResponse.result
        self.timeline = dataResponse.timeline
    }
}

public class DownloadResponseFromAF: DataResponseFromAF {
    
    /// The temporary destination URL of the data returned from the server.
    public let temporaryURL: URL?
    
    /// The final destination URL of the data returned from the server if it was moved.
    public let destinationURL: URL?
    
    /// The resume data generated if the request was cancelled.
    public let resumeData: Data?
    
    public init(downloadResponse: DownloadResponse<Data>)
    {
        self.temporaryURL = downloadResponse.temporaryURL
        self.destinationURL = downloadResponse.destinationURL
        self.resumeData = downloadResponse.resumeData
        super.init(dataResponse: downloadResponse.dataResponse)
    }
}

extension DownloadResponse {
    var dataResponse: DataResponse<Value> {
        return DataResponse(request: request, response: response, data: nil, result: result, timeline: timeline)
    }
}

