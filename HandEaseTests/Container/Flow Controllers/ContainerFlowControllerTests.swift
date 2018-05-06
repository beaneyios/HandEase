//
//  ContainerFlowController.swift
//  HandEaseTests
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import XCTest
@testable import HandEase

class ContainerFlowControllerTests: XCTestCase {
    func testCorrectVCIsSet() {
        let testViewControllerRep   = ViewControllerRepresentations.allExercises
        let testAction              = ItemAction.loadView(viewController: testViewControllerRep)
        let mockContainer           = MockContainerViewController()
        let sut                     = ContainerFlowController(containerVC: mockContainer,
                                                              navigationController: UINavigationController())
        
        sut.handleMenuAction(action: testAction)
        XCTAssert(mockContainer.currentViewController is ExerciseListViewController, "Wrong VC applied")
    }
    
    func testMenuOpensWhenToggleMenuCalled() {
        let mockContainer           = MockContainerViewController()
        let sut                     = ContainerFlowController(containerVC: mockContainer,
                                                              navigationController: UINavigationController())
        
        sut.toggleMenu()
        XCTAssert(mockContainer.menuOpen, "Menu not opened.")
        sut.toggleMenu()
        XCTAssert(!mockContainer.menuOpen, "Menu not closed.")
    }
}

class MockContainerViewController: ViewControllerContaining, MenuOpening {
    var currentViewController: UIViewController?
    var menuOpen: Bool = false
    
    func configure(flowController: Navigator) {
        
    }
    
    func setCurrentViewController(viewController: UIViewController) {
        self.currentViewController = viewController
    }
    
    func toggleMenu() {
        self.menuOpen = !self.menuOpen
    }
}
