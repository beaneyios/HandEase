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
            //MY EXERCISES
            MenuItem(
                strTitle    : .menuMyExercises,
                imgType     : .menuHeartIcon,
                foreColor   : .menuForeColor,
                action      : .loadView(viewController: ViewControllers.myExercises)
            ),
            
            //ALL EXERCISES
            MenuItem(
                strTitle    : .menuAllExercises,
                imgType     : .menuDoublePageIcon,
                foreColor   : .menuForeColor,
                action      : .loadView(viewController: ViewControllers.allExercises)
            ),
            
            //REMIND ME
            MenuItem(
                strTitle    : .menuRemindMe,
                imgType     : .menuClockIcon,
                foreColor   : .menuForeColor,
                action      : .loadView(viewController: ViewControllers.remindMe)
            ),
            
            //PROGRESS
            MenuItem(
                strTitle    : .menuProgress,
                imgType     : .menuPersonIcon,
                foreColor   : .menuForeColor,
                action      : .loadView(viewController: ViewControllers.progress)
            ),
            
            //LEAFLETS
            MenuItem(
                strTitle    : .menuLeaflets,
                imgType     : .menuLeafletIcon,
                foreColor   : .menuForeColor,
                action      : .loadView(viewController: ViewControllers.leaflets)
            ),
            
            //ABOUT
            MenuItem(
                strTitle    : .menuAbout,
                imgType     : .menuInfoIcon,
                foreColor   : .menuForeColor,
                action      : .loadView(viewController: ViewControllers.about)
            ),
        ]
    }
}
