//
//  ContainerFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 01/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

/// - This class broadly speaking achieves navigation in response to requests from view controllers, specifically:
/// - Menu navigation via a container.
/// - Navigation controller based navigation to other views not held in the container.
typealias MenuContainer = ViewControllerContaining & MenuOpening

class ContainerFlowController: ExerciseFlowController {
    var containerVC: MenuContainer
    var navigationController: UINavigationController
    
    init(containerVC: MenuContainer, navigationController: UINavigationController) {
        self.containerVC = containerVC
        self.navigationController = navigationController
    }
    
    func closeCurrentVC(viewController: UIViewController) {
        self.navigationController.popViewController(animated: true)
    }
    
    func exerciseTapped(exercise: ExerciseViewModel) {
        if let vc = ViewControllers.exercise as? ExerciseViewController {
            vc.configure(flowController: self, exercise: exercise)
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
}

extension ContainerFlowController: MenuActionDelegate {
    public func handleMenuAction(action: ItemAction) {
        switch action {
        case .loadView(viewController: let viewControllerRep):
            if let vc = UIStoryboard.viewController(for: viewControllerRep) {
                containerVC.setCurrentViewController(viewController: vc)
            }
        }
    }
}

extension ContainerFlowController: MenuOpening {
    public func toggleMenu() {
        self.containerVC.toggleMenu()
    }
}
