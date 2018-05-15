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
    var navigationController: UINavigationController      { get }
    
    func closeCurrentVC(viewController: UIViewController)
}

protocol ExerciseFlowController: FlowController {
    func exerciseTapped(exercise: ExerciseViewModel)
}
