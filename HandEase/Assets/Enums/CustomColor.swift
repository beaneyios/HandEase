//
//  CustomColor.swift
//  HandEase
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

enum CustomColor {
    case menuForeColor
    
    var uiColor: UIColor {
        switch self {
        case .menuForeColor: return UIColor.white
        }
    }
}


