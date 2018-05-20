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

class ExerciseListViewModelFactory: ExerciseListViewModelCreating {
    func allExercisesViewModel(fetcher: ExerciseFetching, imageDownloaderFactory: ImageDownloaderCreating, favouriter: ExerciseFetching & ExerciseFavouriting, navigator: ExerciseFlowController) -> AllExercisesListViewModel {
        let config = AllExercisesListViewModel.Config(exerciseFetcher: fetcher,
                                                            navigator: navigator,
                                                            imageDownloaderFactory: imageDownloaderFactory,
                                                            favouriter: favouriter)
        return AllExercisesListViewModel(dependencies: config)
    }
    
    func myExercisesViewModel(imageDownloaderFactory: ImageDownloaderCreating, favouriter: ExerciseFetching & ExerciseFavouriting, navigator: ExerciseFlowController) -> MyExercisesListViewModel {
        let config = MyExercisesListViewModel.Config(navigator: navigator,
                                                     imageDownloaderFactory: imageDownloaderFactory,
                                                     favouriter: favouriter)
        return MyExercisesListViewModel(dependencies: config)
    }
}

class ExerciseViewModelFactory: ExerciseViewModelCreating {
    private var imageDownloader: ImageDownloading
    private var favouriter: ExerciseFetching & ExerciseFavouriting
    init(imageDownloader: ImageDownloading, favouriter: ExerciseFetching & ExerciseFavouriting) {
        self.imageDownloader = imageDownloader
        self.favouriter = favouriter
    }
    
    func exerciseViewModel(exercise: Exercise) -> ExerciseViewModel {
        let config = ExerciseViewModel.Config(favouriter: self.favouriter, imageDownloader: self.imageDownloader)
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
