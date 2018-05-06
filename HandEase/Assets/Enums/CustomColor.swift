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
    case menuItemForeColor
    case menuItemBackColor
    case swooshSelectionColor
    
    var uiColor: UIColor {
        switch self {
        case .menuItemForeColor: return UIColor.white
        case .menuItemBackColor: return #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        case .swooshSelectionColor: return #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }
    }
}

