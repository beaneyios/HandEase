//
//  HasDependencies.swift
//  HandEase
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

//Core dependencies
protocol HasImageDownloaderFactory {
    var imageDownloaderFactory: ImageDownloaderCreating { get }
}

//Navigation
protocol HasExerciseFlowController {
    var navigator: ExerciseFlowController { get }
}

//Exercise dependencies
protocol HasExerciseFetcher {
    var exerciseFetcher: ExerciseFetching { get }
}

//Menu dependencies
protocol HasMenuItemSizer {
    var sizer: MenuItemSizer { get }
}

protocol HasMenuItemDataSource {
    var dataSource: MenuItemDataSource { get }
}

protocol HasMenuTheme {
    var theme: MenuTheme { get }
}
