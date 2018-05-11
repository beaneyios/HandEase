//
//  ExerciseListViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class DefaultExerciseListViewModel: NSObject, ExerciseListViewModel {
    var action: ExerciseItemActionClosure?
    private var fetcher: ExerciseFetching
    private var exercises: [Exercise] = []
    
    init(fetcher: ExerciseFetching) {
        self.fetcher = fetcher
    }
    
    func bind(cview: UICollectionView) {
        cview.register          (SmallExerciseCell.nib, forCellWithReuseIdentifier: "standard_cell")
        cview.delegate          = self
        cview.dataSource        = self
        
        self.fetcher.fetchExercises { (result) in
            switch result {
            case .success(exercises: let exercises):
                self.exercises = exercises
            case .failure(error: let error, defaultExercises: let exercises):
                print(error)
                self.exercises = exercises
            }
            
            DispatchQueue.main.async {
                cview.reloadData()
            }
        }
    }
}

extension DefaultExerciseListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "standard_cell", for: indexPath)
        guard let castCell  = cell as? SmallExerciseCell else { return SmallExerciseCell() }
        
        let exercise        = self.exercises[indexPath.row]
        castCell.configure  (viewModel: DefaultExerciseViewModel(exercise: exercise))
        return cell
    }
}

extension DefaultExerciseListViewModel: UICollectionViewDelegate {
    
}

extension DefaultExerciseListViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}
