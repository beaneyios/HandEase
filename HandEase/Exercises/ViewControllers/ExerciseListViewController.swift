//
//  MyExercisesViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 29/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class ExerciseListViewController: UIViewController {
    private var flowController: Navigator!
    
    @IBAction func toggleMenu(_ sender: Any) {
        self.toggleMenu()
    }
    
    func configure(flowController: Navigator) {
        self.flowController = flowController
    }
}

extension ExerciseListViewController: MenuOpening {
    func toggleMenu() {
        self.flowController?.toggleMenu()
    }
}
