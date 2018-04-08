//
//  MenuItemCollectionViewCells.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import XCTest
@testable import HandEase

class MenuItemCollectionViewCellTests: XCTestCase {
    func testThatCellInflatesCorrectly() {
        guard let cell = self.fetchCellClass() else {
            XCTFail("Couldn't load nib")
            return
        }
        
        let menuItem    = MenuItem(strTitle: .menuAbout, imgType: .menuInfoIcon)
        let vm          = DefaultMenuItemViewModel(menuItem: menuItem)
        cell.configure(with: vm)
        
        XCTAssert(cell.lblTitle.text == "About", "Cell text not 'About'")
        XCTAssert(cell.imgIcon.image == #imageLiteral(resourceName: "info"), "Cell image not correct")
    }
    
    private func fetchCellClass() -> MenuItemCollectionViewCell? {
        return Bundle.main.loadNibNamed(String(describing: MenuItemCollectionViewCell.self), owner: self, options: nil)?.first as? MenuItemCollectionViewCell
    }
}

