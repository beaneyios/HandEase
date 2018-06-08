//
//  ExerciseFactories.swift
//  HandEase
//
//  Created by Matt Beaney on 07/06/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

/// Creates a class that will fetch a list of exercises.
class ExerciseFetcherFactory: ExerciseFetcherCreating {
    func exerciseFetcher() -> ExerciseFetching {
        return ExerciseFetcher(getter: NetworkGetter(), cacher: Cacher(ttlManager: TTLManager()))
    }
}

/// Creates a class that manages favouriting of exercises.
class ExerciseFavouriterFactory: ExerciseFavouriterCreating {
    func exerciseFavouriter() -> ExerciseFavouriting & ExerciseFetching {
        let config = ExerciseFavouriter.Config(cacher: Cacher(ttlManager: TTLManager()))
        return ExerciseFavouriter(dependencies: config)
    }
}

/// Creates a class that facilitates binding of exercises to a collection view.
class ExerciseListViewModelFactory: ListViewModelCreating {
    private var exerciseViewModelFactory    : ExerciseViewModelCreating
    private var favouriter                  : ExerciseFetching & ExerciseFavouriting
    private var fetcher                     : ExerciseFetching
    private var imageDownloaderFactory      : ImageDownloaderCreating
    private var tracker                     : ExerciseTracking
    
    init(exerciseViewModelFactory: ExerciseViewModelCreating,
         fetcher: ExerciseFetching,
         favouriter: ExerciseFetching & ExerciseFavouriting,
         imageDownloaderFactory: ImageDownloaderCreating,
         tracker: ExerciseTracking) {
        self.tracker = tracker
        self.imageDownloaderFactory = imageDownloaderFactory
        self.exerciseViewModelFactory = exerciseViewModelFactory
        self.fetcher = fetcher
        self.favouriter = favouriter
    }
    
    func progressListViewModel(navigator: ExerciseFlowController) -> ListViewModel {
        let config = ProgressListViewModel.Config(tracker: tracker,
                                                  imageDownloaderFactory: imageDownloaderFactory,
                                                  navigator: navigator,
                                                  exerciseViewModelFactory: exerciseViewModelFactory)
        return ProgressListViewModel(dependencies: config)
    }
    
    func allExercisesViewModel(navigator: ExerciseFlowController) -> ListViewModel {
        let config = AllExercisesListViewModel.Config(exerciseFetcher: fetcher,
                                                      navigator: navigator,
                                                      imageDownloaderFactory: imageDownloaderFactory,
                                                      favouriter: favouriter,
                                                      tracker: tracker)
        return AllExercisesListViewModel(dependencies: config)
    }
    
    func myExercisesViewModel(navigator: ExerciseFlowController) -> ListViewModel {
        let config = MyExercisesListViewModel.Config(navigator: navigator,
                                                     imageDownloaderFactory: imageDownloaderFactory,
                                                     favouriter: favouriter,
                                                     tracker: tracker)
        return MyExercisesListViewModel(dependencies: config)
    }
}

/// Creates a class that tracks exercise interactions.
class ExerciseTrackerFactory: ExerciseTrackerCreating {
    func exerciseTracker() -> ExerciseTracking {
        let cacher = Cacher(ttlManager: TTLManager())
        let config = ExerciseTracker.Config(cacher: cacher)
        return ExerciseTracker(dependencies: config)
    }
}

/// Creates a class that manages a single exercise.
class ExerciseViewModelFactory: ExerciseViewModelCreating {
    func exerciseViewModel(exercise: Exercise) -> ExerciseViewModel {
        
        let favouriterFactory       = ExerciseFavouriterFactory()
        let imageDownloaderFactory  = ImageDownloaderFactory()
        let tracker                 = ExerciseTrackerFactory()
        
        let config = ExerciseViewModel.Config(favouriter        : favouriterFactory.exerciseFavouriter(),
                                              imageDownloader   : imageDownloaderFactory.imageDownloader(),
                                              tracker           : tracker.exerciseTracker())
        return ExerciseViewModel(exercise: exercise, dependencies: config)
    }
}
