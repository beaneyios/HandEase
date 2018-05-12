//
//  ExerciseListViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBNetworking

class ExerciseListViewModel: NSObject, ExerciseListViewModelling {
    typealias Dependencies = HasExerciseFetcher & HasExerciseFlowController
    private var dependencies: Dependencies
    
    private var exercises: [Exercise] = []
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func bind(cview: UICollectionView) {
        cview.register          (SmallExerciseCell.nib, forCellWithReuseIdentifier: "standard_cell")
        cview.delegate          = self
        cview.dataSource        = self
        
        self.dependencies.exerciseFetcher.fetchExercises(force: false) { (result) in
            switch result {
            case .success(exercises: let exercises):
                self.exercises = exercises
            case .failure(error: let error, defaultExercises: let exercises):
                self.updateErrorUI(error: error, defaultExercises: exercises)
            }
            
            DispatchQueue.main.async {
                cview.reloadData()
            }
        }
    }
    
    private func updateErrorUI(error: CustomError, defaultExercises: [Exercise]?) {
        //TODO: Handle error front end.
    }
    
    struct Config: Dependencies {
        var exerciseFetcher: ExerciseFetching
        var navigator: ExerciseFlowController
    }
}

extension ExerciseListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "standard_cell", for: indexPath)
        guard let castCell  = cell as? SmallExerciseCell else { return SmallExerciseCell() }
        
        let exercise        = self.exercises[indexPath.row]
        let downloader      = self.fetchImageDownloader()
        castCell.configure  (viewModel: ExerciseViewModel(exercise: exercise, imageDownloader: downloader))
        castCell.exerciseTap = {
            self.dependencies.navigator.exerciseTapped(exercise: exercise)
        }
        return cell
    }
    
    private func fetchImageDownloader() -> ImageDownloader {
        let getter = NetworkGetter()
        let cacher = Cacher(ttlManager: TTLManager())
        return ImageDownloader(getter: getter, cacher: cacher)
    }
}

extension ExerciseListViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}
