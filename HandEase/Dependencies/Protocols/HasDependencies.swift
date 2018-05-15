//
//  HasDependencies.swift
//  HandEase
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

protocol HasExerciseFlowController {
    var navigator: ExerciseFlowController { get }
}

protocol HasExerciseFetcher {
    var exerciseFetcher: ExerciseFetching { get }
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


