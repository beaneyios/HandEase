//
//  MenuFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

class MenuFlowController {
    private var parentFlowController: FlowController
    
    init(parentFlowController: FlowController) {
        self.parentFlowController = parentFlowController
    }
}

extension MenuFlowController: MenuActionDelegate {
    public func handleMenuAction(action: ItemAction) {
        switch action {
        case .loadView(viewController: let viewControllerRep):
            self.parentFlowController.navigate(to: viewControllerRep)
        }
    }
}

extension MenuFlowController: MenuOpening {
    public func toggleMenu() {
        self.parentFlowController.navigate(to: ViewControllerRepresentations.menu)
    }
}
