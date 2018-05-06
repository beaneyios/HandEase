//
//  ImageTypeTests.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import XCTest
@testable import HandEase

class ImageTypeTests: XCTestCase {
    func testThatAllKeysHaveAValue() {
        for key in ImageType.allKeys {
            XCTAssertNotNil(UIImage(type: key), "\(key.stringlyTypedImage) was nil")
        }
    }
}
