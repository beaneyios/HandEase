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
                                                    exerciseFetcherFactory      : ExerciseFetcherFactory(),
                                                    imageDownloaderFactory      : ImageDownloaderFactory(),
                                                    containerFactory            : ContainerFactory(),
                                                    exerciseFavouriterFactory   : ExerciseFavouriterFactory(),
                                                    exerciseListViewModelFactory: ExerciseListViewModelFactory(),
                                                    exerciseTrackerFactory      : ExerciseTrackerFactory(), exerciseViewModelFactory: ExerciseViewModelFactory())
        
        return ContainerFlowController(rootVC: ViewControllerRepresentations.allExercises,
                                       dependencies: config)
    }
}
