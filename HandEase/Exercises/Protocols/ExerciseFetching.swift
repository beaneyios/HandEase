//
//  ExerciseRepository.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

enum ExerciseResult {
    case success(exercises: [Exercise])
    case failure(error: Error, defaultExercises: [Exercise])
}

typealias ExerciseFetchCompletion = (_ result: ExerciseResult) -> Void
protocol ExerciseFetching {
    func fetchExercises(completion: @escaping ExerciseFetchCompletion)
}
