//
//  LocalMenuDataSourceTests.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import XCTest
@testable import HandEase

class LocalMenuDataSourceTests: XCTestCase {
    func testThatDataSourceReturnsCorrectNumberOfItems() {
        let sut     = LocalMenuDataSource()
        let items   = sut.fetchMenuItems()
        XCTAssert(items.count == 6)
    }
}
