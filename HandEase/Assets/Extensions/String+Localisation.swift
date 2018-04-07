//
//  String+Localisation.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

extension String {
    init?(localised: LocalisedKey) {
        self = NSLocalizedString(localised.rawValue, comment: "")
    }
}
