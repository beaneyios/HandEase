//
//  ContainerFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 01/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class DefaultContainerFlowController : ContainerFlowController {
    var container: HomeContainerViewController
    var navigation: UINavigationController
    
    init(container: HomeContainerViewController, navigation: UINavigationController) {
        self.container = container
        self.navigation = navigation
    }
    
    func handleMenuAction(action: ItemAction) {
        switch action {
        case .loadView(viewController: let viewControllerRep):
            if let vc = UIStoryboard.viewController(for: viewControllerRep) {
                container.setCurrentViewController(viewController: vc)
            }
        }
    }
}
