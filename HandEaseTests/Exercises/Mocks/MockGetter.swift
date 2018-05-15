//
//  MockGetter.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
@testable import MBNetworking

class MockGetter: Getter {
    var shouldSucceed: Bool = true
    var timeout: Double = 0.0
    var resourcePath: String
    var resourceType: String
    
    init(with resourcePath: String, andType type: String) {
        self.resourcePath = resourcePath
        self.resourceType = type
    }
    
    func get(url: URL, timeout: Double, completion: @escaping DownloadCompletion) -> URLSessionDataTaskProtocol? {
        self.timeout = timeout
        self.mockGet(url: url, completion: completion)
        return nil
    }
    
    func get(req: URLRequest, session: URLSessionProtocol, completion: @escaping DownloadCompletion) -> URLSessionDataTaskProtocol? {
        guard let url = req.url else {
            completion(DownloadResult.failure(error: nil))
            return nil
        }
        
        self.mockGet(url: url, completion: completion)
        return nil
    }
    
    fileprivate func mockGet(url: URL, completion: @escaping DownloadCompletion) {
        if shouldSucceed {
            let successfulHTTP = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            let successfulResult = DownloadResult.success(data: self.fetchSuccessfulData(), response: successfulHTTP!)
            completion(successfulResult)
            return
        }
        
        let error = NSError(domain: "com.test.failure", code: -1001, userInfo: nil)
        completion(DownloadResult.failure(error: error))
    }
    
    fileprivate func fetchSuccessfulData() -> Data {
        let bundle = Bundle(for: MockGetter.self)
        let dataURL = bundle.url(forResource: self.resourcePath, withExtension: self.resourceType)!
        return try! Data(contentsOf: dataURL)
    }
}
