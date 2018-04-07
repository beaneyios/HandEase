//
//  DefaultMenuItemViewModelTests.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import XCTest
@testable import HandEase

class DefaultMenuItemViewModelTests: XCTestCase {
    override func setUp() {
        
    }
    
    func testThatCorrectTitleReturnedForMenuItem() {
        let testMenuItem = MenuItem(strTitle: .menuAbout, imgType: .menuInfoIcon)
        let sut = DefaultMenuItemViewModel(menuItem: testMenuItem)
        
    }
}
