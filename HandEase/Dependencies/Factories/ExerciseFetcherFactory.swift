//
//  ExerciseFetcherFactory.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class ExerciseFetcherFactory: ExerciseFetcherCreating {
    func exerciseFetcher() -> ExerciseFetching {
        return ExerciseFetcher(getter: NetworkGetter(), cacher: Cacher(ttlManager: TTLManager()))
    }
}
