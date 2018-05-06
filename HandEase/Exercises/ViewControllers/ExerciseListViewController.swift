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
    @IBOutlet weak var collectionView: UICollectionView!
    private var flowController: Navigator!
    private var viewModel: ExerciseListViewModel!
    
    @IBAction func toggleMenu(_ sender: Any) {
        self.toggleMenu()
    }
    
    func configure(flowController: Navigator, viewModel: ExerciseListViewModel) {
        self.flowController     = flowController
        self.viewModel          = viewModel
    }
    
    override func viewDidLoad() {
        self.viewModel.bind(cview: self.collectionView)
    }
}

extension ExerciseListViewController: MenuOpening {
    func toggleMenu() {
        self.flowController?.toggleMenu()
    }
}
