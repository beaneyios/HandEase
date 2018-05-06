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
        
        let testMenuItem    = MenuItem(strTitle: .menuAbout,
                                       imgType: .menuInfoIcon,
                                       foreColor: .menuItemForeColor,
                                       backColor: .menuItemBackColor,
                                       action: .loadView(viewController: ViewControllerRepresentations.about))
        let vm              = DefaultMenuItemViewModel(menuItem: testMenuItem)
        cell.configure(with: vm)
        
        let expTitle        = "About"
        let expImg          = #imageLiteral(resourceName: "info").withRenderingMode(.alwaysTemplate)
        
        XCTAssert(cell.lblTitle.text == expTitle, "Cell text not 'About'")
        XCTAssert(cell.imgIcon.image == expImg, "Cell image not correct")
    }
    
    private func fetchCellClass() -> MenuItemCollectionViewCell? {
        return Bundle.main.loadNibNamed(String(describing: MenuItemCollectionViewCell.self), owner: self, options: nil)?.first as? MenuItemCollectionViewCell
    }
}

