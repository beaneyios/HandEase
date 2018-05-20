//
//  HasDependencies.swift
//  HandEase
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

protocol HasCacher {
    var cacher: Cacheable { get }
}

protocol HasExerciseFlowController {
    var navigator: ExerciseFlowController { get }
}

protocol HasExerciseFavouriter {
    var favouriter: ExerciseFetching & ExerciseFavouriting { get }
}

protocol HasExerciseFetcher {
    var exerciseFetcher: ExerciseFetching { get }
}

protocol HasImageDownloader {
    var imageDownloader: ImageDownloading { get }
}

protocol HasMenuItemSizer {
    var sizer: MenuItemSizer { get }
}

protocol HasMenuItemDataSource {
    var dataSource: MenuItemDataSource { get }
}

protocol HasMenuTheme {
    var theme: MenuTheme { get }
}

protocol HasMenuFlowController {
    var menuFlowController: MenuHandler { get }
}


