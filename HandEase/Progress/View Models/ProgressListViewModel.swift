//
//  ProgressListViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 20/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class ProgressListViewModel: NSObject, ListViewModel {
    typealias Dependencies = HasExerciseTracker & HasImageDownloaderFactory & HasExerciseFlowController & HasExerciseViewModelFactory
    private var dependencies: Dependencies
    private var imageDownloader: ImageDownloading { return self.dependencies.imageDownloaderFactory.imageDownloader() }
    
    private var exercises: [ExerciseEvent] = [ExerciseEvent]()
    
    struct Config: Dependencies {
        var tracker: ExerciseTracking
        var imageDownloaderFactory: ImageDownloaderCreating
        var navigator: ExerciseFlowController
        var exerciseViewModelFactory: ExerciseViewModelCreating
    }
    
    private var tracker: ExerciseTracking { return self.dependencies.tracker }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func bind(cview: UICollectionView) {
        self.exercises = self.tracker.fetchTrackedExercises()
        
        cview                   .register(ExerciseEventCell.nib, forCellWithReuseIdentifier: "standard_cell")
        cview.delegate          = self
        cview.dataSource        = self
    }
}

extension ProgressListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let cell                = collectionView.dequeueReusableCell(withReuseIdentifier: "standard_cell", for: indexPath)
        guard let castCell      = cell as? ExerciseEventCell else { return ExerciseEventCell() }
        let exerciseEvent       = self.exercises[indexPath.row]
        let vm                  = self.viewModel(for: exerciseEvent)
        let exerciseVM          = self.dependencies.exerciseViewModelFactory.exerciseViewModel(exercise: exerciseEvent.exercise)
        
        castCell.exerciseTap    = { self.dependencies.navigator.exerciseTapped(exercise: exerciseVM) }
        castCell.configure      (viewModel: vm)
        return cell
    }
    
    private func viewModel(for exerciseEvent: ExerciseEvent) -> ExerciseEventViewModel {
        let config          = ExerciseEventViewModel.Config(imageDownloader: imageDownloader, tracker: tracker)
        let vm              = ExerciseEventViewModel(exerciseEvent: exerciseEvent, dependencies: config)
        return vm
    }
}

extension ProgressListViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 350.0)
    }
}
