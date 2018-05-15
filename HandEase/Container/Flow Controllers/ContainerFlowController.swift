//
//  ContainerFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 01/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

typealias SlideMenuExerciseContainer = ViewControllerContaining & MenuOpening

class ContainerFlowController: ExerciseFlowController {
    var containerVC: SlideMenuExerciseContainer
    var navigationController: UINavigationController
    
    init(containerVC: SlideMenuExerciseContainer, navigationController: UINavigationController) {
        self.containerVC = containerVC
        self.navigationController = navigationController
    }
    
    /**
     Handles opening a specific exercise.
     - parameter exercise: The view model representing the exercise itself.
    */
    func exerciseTapped(exercise: ExerciseViewModel) {
        guard let vc = ViewControllers.exercise as? ExerciseViewController else { return }
        vc.configure(flowController: self, exercise: exercise)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func exerciseVideoTapped(exercise: ExerciseViewModel) {
        guard let vc = ViewControllers.video as? ExerciseVideoViewController else { return }
        vc.configure(exercise: exercise, flowController: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigate(to vc: StoryboardRepresentation) {
        if vc == ViewControllerRepresentations.menu {
            self.containerVC.toggleMenu()
            return
        }
        
        if let vc = UIStoryboard.viewController(for: vc) {
            containerVC.setCurrentViewController(viewController: vc)
        }
    }
    
    func closeCurrentVC(viewController: UIViewController) {
        self.navigationController.popViewController(animated: true)
    }
}
