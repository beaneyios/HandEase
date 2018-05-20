//
//  FactoryProtocols.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

protocol CacherCreating {
    func cacher() -> Cacher
}

protocol ContainerCreating {
    func container(flowController: ExerciseFlowController, menuDelegate: MenuHandler) -> SlideMenuExerciseContainer?
}

protocol ExerciseFavouriterCreating {
    func exerciseFavouriter() -> ExerciseFetching & ExerciseFavouriting
}

protocol ExerciseFetcherCreating {
    func exerciseFetcher() -> ExerciseFetching
}

protocol ExerciseViewModelCreating {
    func exerciseViewModel(exercise: Exercise) -> ExerciseViewModel
}

protocol ExerciseListViewModelCreating {
    func allExercisesViewModel(fetcher: ExerciseFetching, imageDownloaderFactory: ImageDownloaderCreating, favouriter: ExerciseFetching & ExerciseFavouriting, navigator: ExerciseFlowController) -> AllExercisesListViewModel
    func myExercisesViewModel(imageDownloaderFactory: ImageDownloaderCreating, favouriter: ExerciseFetching & ExerciseFavouriting, navigator: ExerciseFlowController) -> MyExercisesListViewModel
}

protocol ImageDownloaderCreating {
    func imageDownloader() -> ImageDownloader
}

protocol MenuFlowControllerCreating {
    func menuFlowController(parent: FlowController) -> MenuHandler
}
