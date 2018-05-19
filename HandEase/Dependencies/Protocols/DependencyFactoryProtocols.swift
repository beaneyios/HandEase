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

protocol ExerciseFetcherCreating {
    func exerciseFetcher() -> ExerciseFetching
}

protocol ExerciseViewModelCreating {
    func exerciseViewModel(exercise: Exercise) -> ExerciseViewModel
}

protocol ImageDownloaderCreating {
    func imageDownloader() -> ImageDownloader
}

protocol MenuFlowControllerCreating {
    func menuFlowController(parent: FlowController) -> MenuHandler
}
