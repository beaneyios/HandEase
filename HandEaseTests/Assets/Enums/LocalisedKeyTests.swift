//
//  LocalisedKeyTests.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import XCTest
@testable import HandEase

class LocalisedKeyTests: XCTestCase {
    func testThatAllKeysHaveAValue() {
        for key in LocalisedKey.allKeys {
            let sut = String(localised: key)
            XCTAssertNotNil(sut)
            XCTAssert(sut != key.rawValue, "\(key.rawValue) hasn't got a value.")
        }
    }
}
