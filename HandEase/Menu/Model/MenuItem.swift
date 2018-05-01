//
//  MenuItem.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

struct MenuItem {
    var strTitle    : LocalisedKey
    var imgType     : ImageType
    var foreColor   : CustomColor
    var backColor   : CustomColor
    var action      : ItemAction
}
