//
//  ImageType.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

enum ImageType {
    case menuClockIcon
    case menuDoublePageIcon
    case menuInfoIcon
    case menuLeafletIcon
    case menuPersonIcon
    case menuPlusIcon
    case menuStarIcon
    
    var stringlyTypedImage: String {
        switch self {
            case .menuClockIcon: return ""
            case .menuDoublePageIcon: return ""
            case .menuInfoIcon: return ""
            case .menuLeafletIcon: return ""
            case .menuPersonIcon: return ""
            case .menuPlusIcon: return ""
            case .menuStarIcon: return ""
        }
    }
    
    static var allKeys: Set<ImageType> {
        return [
            .menuClockIcon,
            .menuDoublePageIcon,
            .menuInfoIcon,
            .menuLeafletIcon,
            .menuPersonIcon,
            .menuPlusIcon,
            .menuStarIcon,
        ]
    }
}
