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
    case menuHeartIcon
    case exerciseHeartIcon
    case exerciseHeartIconSaved
    
    var stringlyTypedImage: String {
        switch self {
            case .menuClockIcon: return "clock"
            case .menuDoublePageIcon: return "double-page"
            case .menuInfoIcon: return "info"
            case .menuLeafletIcon: return "leaflet"
            case .menuPersonIcon: return "person"
            case .menuPlusIcon: return "plus"
            case .menuHeartIcon: return "heart-unsaved"
            case .exerciseHeartIcon: return "heart-unsaved"
            case .exerciseHeartIconSaved: return "heart-saved"
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
            .menuHeartIcon,
            .exerciseHeartIcon,
            .exerciseHeartIconSaved
        ]
    }
}
