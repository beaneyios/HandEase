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
    
    private var viewModel           : ListViewModel!
            
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.bind(cview: self.collectionView)
    }
}

extension ExerciseListViewController: ListConfigurable {
    func configure(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
}
