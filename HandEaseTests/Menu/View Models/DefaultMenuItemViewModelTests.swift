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
    var debugLocaleString: String = "AppleLanguages"
    override func setUp() {
        UserDefaults.standard.removeObject(forKey: self.debugLocaleString)
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: self.debugLocaleString)
    }
    
    func testThatCorrectEnglishTitleReturnedForMenuItem() {
        //GIVEN an English locale.
        UserDefaults.standard.set(["en"], forKey: self.debugLocaleString)
    
        let testMenuItem = MenuItem(strTitle: .menuAbout, imgType: .menuInfoIcon)
        let sut = DefaultMenuItemViewModel(menuItem: testMenuItem)
        XCTAssert(sut.strTitle == "About")
    }
    
    func testThatImageReturnedForMenuItem() {
        let testMenuItem = MenuItem(strTitle: .menuAbout, imgType: .menuInfoIcon)
        let sut = DefaultMenuItemViewModel(menuItem: testMenuItem)
        
        XCTAssertNotNil(sut.imgIcon)
        XCTAssert(sut.imgIcon == #imageLiteral(resourceName: "info"))
    }
}
