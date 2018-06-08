//
//  ContainerFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 01/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

protocol FlowController: class {
    var navigationController: UINavigationController!      { get }
    func setRootViewController()
    func navigate(to vc: StoryboardRepresentation)
    func closeCurrentVC(viewController: UIViewController)
}

protocol ExerciseFlowController: FlowController {
    func exerciseTapped(exercise: ExerciseViewModel)
    func exerciseVideoTapped(exercise: ExerciseViewModel)
}

extension FlowController {
    /**
     Whatever view sits on top of the stack, this will close it.
     */
    func closeCurrentVC(viewController: UIViewController) {
        self.navigationController.popViewController(animated: true)
    }
}

extension ExerciseFlowController {
    /**
     Handles opening a specific exercise.
     - parameter exercise: The view model representing the exercise itself.
     */
    func exerciseTapped(exercise: ExerciseViewModel) {
        guard let vc = ViewControllers.exercise as? ExerciseViewController else { return }
        vc.configure(flowController: self, exercise: exercise)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    /**
     Handles opening a specific exercise video.
     - parameter exercise: The view model representing the exercise itself.
     */
    func exerciseVideoTapped(exercise: ExerciseViewModel) {
        guard let vc = ViewControllers.video as? ExerciseVideoViewController else { return }
        vc.configure(exercise: exercise, flowController: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
