//
//  LocalisedKey.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

enum LocalisedKey: String {
    case menuMyExercises    = "menu.myExercises"
    case menuAllExercises   = "menu.allExercises"
    case menuRemindMe       = "menu.remindMe"
    case menuProgress       = "menu.menuProgress"
    case menuLeaflets       = "menu.menuLeaflets"
    case menuDonate         = "menu.menuDonate"
    case menuAbout          = "menu.menuAbout"
    
    var localisedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
