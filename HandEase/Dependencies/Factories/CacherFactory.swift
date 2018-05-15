//
//  CacherFactory.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class CacherFactory: CacherCreating {
    func cacher() -> Cacher {
        return Cacher(ttlManager: TTLManager())
    }
}
