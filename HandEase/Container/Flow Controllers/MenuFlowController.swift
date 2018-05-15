//
//  MenuFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

class MenuFlowController {
    private weak var parentFlowController: FlowController!
    
    init(parentFlowController: FlowController) {
        self.parentFlowController = parentFlowController
    }
}

extension MenuFlowController: MenuActionDelegate {
    /**
     Handles actions delivered up from the menu view controller.
     Currently this only involves loading view controllers.
     - parameter action: The action bubbled up from the menu tap.
    */
    public func handleMenuAction(action: ItemAction) {
        switch action {
        case .loadView(viewController: let viewControllerRep):
            self.parentFlowController.navigate(to: viewControllerRep)
        }
    }
}

extension MenuFlowController: MenuOpening {
    /**
     Decides, based on an action consuming this delegate, to open/close the menu.
    */
    public func toggleMenu() {
        self.parentFlowController.navigate(to: ViewControllerRepresentations.menu)
    }
}
