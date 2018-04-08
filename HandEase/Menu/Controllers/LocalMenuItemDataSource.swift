//
//  LocalMenuDataSource.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

struct LocalMenuItemDataSource : MenuItemDataSource {    
    var items: [MenuItem] {
        return [
            MenuItem(strTitle: .menuMyExercises,    imgType: .menuHeartIcon, foreColor: .menuForeColor),
            MenuItem(strTitle: .menuAllExercises,   imgType: .menuDoublePageIcon, foreColor: .menuForeColor),
            MenuItem(strTitle: .menuRemindMe,       imgType: .menuClockIcon, foreColor: .menuForeColor),
            MenuItem(strTitle: .menuProgress,       imgType: .menuPersonIcon, foreColor: .menuForeColor),
            MenuItem(strTitle: .menuLeaflets,       imgType: .menuLeafletIcon, foreColor: .menuForeColor),
            MenuItem(strTitle: .menuAbout,          imgType: .menuInfoIcon, foreColor: .menuForeColor),
        ]
    }
}
