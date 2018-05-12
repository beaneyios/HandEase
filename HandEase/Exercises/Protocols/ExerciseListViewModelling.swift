//
//  ExerciseListViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

typealias ExerciseItemActionClosure = (_ action: Exercise) -> ()

protocol ExerciseListViewModelling {
    func bind(cview: UICollectionView)
}
