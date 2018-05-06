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
            //MARK: MY EXERCISES
            MenuItem(
                strTitle    : .menuMyExercises,
                imgType     : .menuHeartIcon,
                foreColor   : .menuItemForeColor,
                backColor   : .menuItemBackColor,
                action      : .loadView(viewController: ViewControllerRepresentations.myExercises)
            ),
            
            //MARK: ALL EXERCISES
            MenuItem(
                strTitle    : .menuAllExercises,
                imgType     : .menuDoublePageIcon,
                foreColor   : .menuItemForeColor,
                backColor   : .menuItemBackColor,
                action      : .loadView(viewController: ViewControllerRepresentations.allExercises)
            ),
            
            //MARK: REMIND ME
            MenuItem(
                strTitle    : .menuRemindMe,
                imgType     : .menuClockIcon,
                foreColor   : .menuItemForeColor,
                backColor   : .menuItemBackColor,
                action      : .loadView(viewController: ViewControllerRepresentations.remindMe)
            ),
            
            //MARK: PROGRESS
            MenuItem(
                strTitle    : .menuProgress,
                imgType     : .menuPersonIcon,
                foreColor   : .menuItemForeColor,
                backColor   : .menuItemBackColor,
                action      : .loadView(viewController: ViewControllerRepresentations.progress)
            ),
            
            //MARK: LEAFLETS
            MenuItem(
                strTitle    : .menuLeaflets,
                imgType     : .menuLeafletIcon,
                foreColor   : .menuItemForeColor,
                backColor   : .menuItemBackColor,
                action      : .loadView(viewController: ViewControllerRepresentations.leaflets)
            ),
            
            //MARK: ABOUT
            MenuItem(
                strTitle    : .menuAbout,
                imgType     : .menuInfoIcon,
                foreColor   : .menuItemForeColor,
                backColor   : .menuItemBackColor,
                action      : .loadView(viewController: ViewControllerRepresentations.about)
            )
        ]
    }
}
