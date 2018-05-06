//
//  ExerciseRepository.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

typealias ExerciseFetchCompletion = (_ exercises: [Exercise]) -> Void
protocol ExerciseFetching {
    func fetchExercises(completion: @escaping ExerciseFetchCompletion)
}
