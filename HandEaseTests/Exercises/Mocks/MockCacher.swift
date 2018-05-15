//
//  MockCacher.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
@testable import MBNetworking

class MockCacher: Cacheable {
    var resourcePath: String
    var resourceType: String
    
    var currentData: Data?
    var cachedContent: Bool = false

    init(with resourcePath: String, andType type: String) {
        self.resourcePath = resourcePath
        self.resourceType = type
    }
    
    func get(url: URL) -> DownloadResult {
        if cachedContent {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return DownloadResult.success(data: self.fetchSuccessfulData(), response: response)
        }
        
        return DownloadResult.failure(error: Errors.Caching.NO_STORED_DATA)
    }
    
    func set(url: URL, data: Data) {
        self.currentData = data
    }
    
    fileprivate func fetchSuccessfulData() -> Data {
        let bundle = Bundle(for: MockGetter.self)
        let dataURL = bundle.url(forResource: self.resourcePath, withExtension: self.resourceType)!
        return try! Data(contentsOf: dataURL)
    }
}
