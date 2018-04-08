//
//  MenuItemViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

struct DefaultMenuItemViewModel : MenuItemViewModel {
    private var menuItem: MenuItem
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
    
    var strTitle: String {
        return self.menuItem.strTitle.localisedString
    }
    
    var imgIcon: UIImage? {
        return UIImage(type: self.menuItem.imgType)?.withRenderingMode(.alwaysTemplate)
    }
    
    var foreColor: UIColor {
        return menuItem.foreColor.uiColor
    }    
}
