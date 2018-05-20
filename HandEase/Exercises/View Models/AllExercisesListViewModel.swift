//
//  AllExercisesListViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 20/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBNetworking

class AllExercisesListViewModel: NSObject, ExerciseListViewModelling {
    typealias Dependencies = HasExerciseFetcher & HasExerciseFavouriter & HasExerciseFlowController & HasImageDownloaderFactory
    private var dependencies: Dependencies
    private var favouriter: ExerciseFetching & ExerciseFavouriting { return self.dependencies.favouriter }
    private var imageDownloader: ImageDownloading { return self.dependencies.imageDownloaderFactory.imageDownloader() }
    private var exercises: [Exercise] = []
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func bind(cview: UICollectionView) {
        self.exercises = []
        
        cview                   .register(SmallExerciseCell.nib, forCellWithReuseIdentifier: "standard_cell")
        cview.delegate          = self
        cview.dataSource        = self
        
        self.fetch(cview: cview)
    }
    
    private func fetch(cview: UICollectionView) {
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
        var imageDownloaderFactory: ImageDownloaderCreating
        var favouriter: ExerciseFetching & ExerciseFavouriting
    }
}

extension AllExercisesListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "standard_cell", for: indexPath)
        guard let castCell  = cell as? SmallExerciseCell else { return SmallExerciseCell() }
        
        let exercise        = self.exercises[indexPath.row]
        let vm              = self.viewModel(for: exercise)
        castCell.configure  (viewModel: vm)
        castCell.exerciseTap = { self.dependencies.navigator.exerciseTapped(exercise: vm) }
        castCell.favouriteTap = {
            _ = self.dependencies.favouriter.favourite(exercise: exercise)
            castCell.configureFavourite(viewModel: vm, animated: true)
        }
        return cell
    }
    
    private func viewModel(for exercise: Exercise) -> ExerciseViewModel {
        let config          = ExerciseViewModel.Config(favouriter: favouriter, imageDownloader: imageDownloader)
        let vm              = ExerciseViewModel(exercise: exercise, dependencies: config)
        return vm
    }
}

extension AllExercisesListViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}

