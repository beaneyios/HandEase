//
//  DependencyFactories.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class CacherFactory: CacherCreating {
    func cacher() -> Cacher {
        return Cacher(ttlManager: TTLManager())
    }
}

class ContainerFactory: ContainerCreating {
    func container(flowController: ExerciseFlowController, menuDelegate: MenuHandler) -> SlideMenuExerciseContainer? {
        guard let container = ViewControllers.container as? ContainerViewController else {
            return nil
        }
        
        container.configure(flowController: flowController, menuDelegate: menuDelegate)
        return container
    }
}

class ExerciseFetcherFactory: ExerciseFetcherCreating {
    func exerciseFetcher() -> ExerciseFetching {
        return ExerciseFetcher(getter: NetworkGetter(), cacher: Cacher(ttlManager: TTLManager()))
    }
}

class ExerciseFavouriterFactory: ExerciseFavouriterCreating {
    func exerciseFavouriter() -> ExerciseFavouriting & ExerciseFetching {
        let config = ExerciseFavouriter.Config(cacher: Cacher(ttlManager: TTLManager()))
        return ExerciseFavouriter(dependencies: config)
    }
}

class ExerciseListViewModelFactory: ListViewModelCreating {
    func progressListViewModel(tracker: ExerciseTracking,
                               imageDownloaderFactory: ImageDownloaderCreating,
                               exerciseViewModelFactory: ExerciseViewModelCreating,
                               navigator: ExerciseFlowController) -> ListViewModel {
        let config = ProgressListViewModel.Config(tracker: tracker,
                                                  imageDownloaderFactory: imageDownloaderFactory,
                                                  navigator: navigator,
                                                  exerciseViewModelFactory: exerciseViewModelFactory)
        return ProgressListViewModel(dependencies: config)
    }
    
    func allExercisesViewModel(fetcher: ExerciseFetching,
                               imageDownloaderFactory: ImageDownloaderCreating,
                               favouriter: ExerciseFetching & ExerciseFavouriting,
                               navigator: ExerciseFlowController,
                               tracker: ExerciseTracking) -> ListViewModel {
        let config = AllExercisesListViewModel.Config(exerciseFetcher: fetcher,
                                                            navigator: navigator,
                                                            imageDownloaderFactory: imageDownloaderFactory,
                                                            favouriter: favouriter,
                                                            tracker: tracker)
        return AllExercisesListViewModel(dependencies: config)
    }
    
    func myExercisesViewModel(imageDownloaderFactory: ImageDownloaderCreating,
                              favouriter: ExerciseFetching & ExerciseFavouriting,
                              navigator: ExerciseFlowController,
                              tracker: ExerciseTracking) -> ListViewModel {
        let config = MyExercisesListViewModel.Config(navigator: navigator,
                                                     imageDownloaderFactory: imageDownloaderFactory,
                                                     favouriter: favouriter,
                                                     tracker: tracker)
        return MyExercisesListViewModel(dependencies: config)
    }
}

class ExerciseTrackerFactory: ExerciseTrackerCreating {
    func exerciseTracker() -> ExerciseTracking {
        let cacher = Cacher(ttlManager: TTLManager())
        let config = ExerciseTracker.Config(cacher: cacher)
        return ExerciseTracker(dependencies: config)
    }
}

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

class ImageDownloaderFactory: ImageDownloaderCreating {
    func imageDownloader() -> ImageDownloader {
        let getter = NetworkGetter()
        let cacher = Cacher(ttlManager: TTLManager())
        return ImageDownloader(getter: getter, cacher: cacher)
    }
}

class MenuFlowControllerFactory: MenuFlowControllerCreating {
    func menuFlowController(parent: FlowController) -> MenuHandler {
        return MenuFlowController(parentFlowController: parent)
    }
}
