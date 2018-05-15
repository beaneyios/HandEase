//
//  HasFactoryDependencies.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

protocol HasContainerFactory {
    var containerFactory: ContainerCreating { get }
}

protocol HasExerciseFetcherFactory {
    var exerciseFetcherFactory: ExerciseFetcherCreating { get }
}

protocol HasImageDownloaderFactory {
    var imageDownloaderFactory: ImageDownloaderCreating { get }
}

protocol HasMenuFlowControllerFactory {
    var menuHandlerFactory: MenuFlowControllerFactory { get }
}

protocol HasExerciseViewModelFactory {
    var exerciseViewModelFactory: ExerciseViewModelCreating { get }
}
