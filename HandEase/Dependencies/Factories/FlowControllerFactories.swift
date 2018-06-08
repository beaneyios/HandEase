//
//  FlowControllerFactories.swift
//  HandEase
//
//  Created by Matt Beaney on 07/06/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

class MenuFlowControllerFactory: MenuFlowControllerCreating {
    func menuFlowController(parent: FlowController) -> MenuHandler {
        return MenuFlowController(parentFlowController: parent)
    }
}

class ContainerFlowControllerFactory: ExerciseFlowControllerCreating {
    func exerciseFlowController() -> ExerciseFlowController {
        let config = ContainerFlowController.Config(menuHandlerFactory          : MenuFlowControllerFactory(),
                                                    imageDownloaderFactory      : ImageDownloaderFactory(),
                                                    containerFactory            : ContainerFactory(),
                                                    exerciseListViewModelFactory: self.exerciseListViewModelFactory())
        return ContainerFlowController(rootVC: ViewControllerRepresentations.allExercises,
                                       dependencies: config)
    }
    
    func exerciseListViewModelFactory() -> ListViewModelCreating {
        return ExerciseListViewModelFactory(exerciseViewModelFactory: ExerciseViewModelFactory(),
                                            fetcher: ExerciseFetcherFactory().exerciseFetcher(),
                                            favouriter: ExerciseFavouriterFactory().exerciseFavouriter(),
                                            imageDownloaderFactory: ImageDownloaderFactory(),
                                            tracker: ExerciseTrackerFactory().exerciseTracker())
    }
}

class TabBarFlowControllerFactory: ExerciseFlowControllerCreating {
    func exerciseFlowController() -> ExerciseFlowController {
        let config = TabBarFlowController.Config(imageDownloaderFactory: ImageDownloaderFactory(),
                                                 exerciseListViewModelFactory: self.exerciseListViewModelFactory())
        
        return TabBarFlowController(dependencies: config)
    }
    
    func exerciseListViewModelFactory() -> ListViewModelCreating {
        return ExerciseListViewModelFactory(exerciseViewModelFactory: ExerciseViewModelFactory(),
                                            fetcher: ExerciseFetcherFactory().exerciseFetcher(),
                                            favouriter: ExerciseFavouriterFactory().exerciseFavouriter(),
                                            imageDownloaderFactory: ImageDownloaderFactory(),
                                            tracker: ExerciseTrackerFactory().exerciseTracker())
    }
}
