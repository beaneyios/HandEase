//
//  ExerciseRepository.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

enum ExerciseResult {
    case success(exercises: [Exercise])
    case failure(error: CustomError, defaultExercises: [Exercise]?)
}

typealias ExerciseFetchCompletion = (_ result: ExerciseResult) -> Void
protocol ExerciseFetching {
    func fetchExercises(force: Bool, completion: @escaping ExerciseFetchCompletion)
}
