//
//  ExerciseTracking.swift
//  HandEase
//
//  Created by Matt Beaney on 20/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

protocol ExerciseTracking {
    func fetchTrackedExercises() -> [ExerciseEvent]
    func trackExerciseCompleted(exercise: Exercise)
    func numberOfTracksForGivenExercise(exercise: Exercise) -> Int
}
