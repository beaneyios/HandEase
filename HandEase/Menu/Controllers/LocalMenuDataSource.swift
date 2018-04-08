//
//  LocalMenuDataSource.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

class LocalMenuDataSource : MenuDataSource {
    func fetchMenuItems() -> [MenuItem] {
        return [
            MenuItem(strTitle: .menuMyExercises,    imgType: .menuHeartIcon),
            MenuItem(strTitle: .menuAllExercises,   imgType: .menuDoublePageIcon),
            MenuItem(strTitle: .menuRemindMe,       imgType: .menuClockIcon),
            MenuItem(strTitle: .menuProgress,       imgType: .menuPersonIcon),
            MenuItem(strTitle: .menuLeaflets,       imgType: .menuLeafletIcon),
            MenuItem(strTitle: .menuAbout,          imgType: .menuInfoIcon),
        ]
    }
}
