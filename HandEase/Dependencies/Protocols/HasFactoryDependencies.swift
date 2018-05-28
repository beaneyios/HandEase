//
//  HasFactoryDependencies.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

protocol HasCacherFactory {
    var cacherFactory: CacherCreating { get }
}

protocol HasContainerFactory {
    var containerFactory: ContainerCreating { get }
}

protocol HasExerciseFetcherFactory {
    var exerciseFetcherFactory: ExerciseFetcherCreating { get }
}

protocol HasExerciseFavouriterFactory {
    var exerciseFavouriterFactory: ExerciseFavouriterCreating { get }
}

protocol HasExerciseTrackerFactory {
    var exerciseTrackerFactory: ExerciseTrackerCreating { get }
}

protocol HasExerciseListViewModelFactory {
    var exerciseListViewModelFactory: ListViewModelCreating { get }
}

protocol HasProgressListViewModelFactory {
    var progressListViewModelFactory: ListViewModelCreating { get }
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
