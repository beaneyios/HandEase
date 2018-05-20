//
//  ExerciseEvent.swift
//  HandEase
//
//  Created by Matt Beaney on 20/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

struct ExerciseEvent: Codable, Equatable {
    var exercise: Exercise
    var date: Date
    
    init(exercise: Exercise) {
        self.exercise = exercise
        self.date = Date()
    }
    
    /**
     Our feed is delivered via JSON, we need to be able to map this to an object.
     - parameter data: The data returned representing the JSON feed.
     */
    static func parseJSON(data: Data) -> [ExerciseEvent]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([ExerciseEvent].self, from: data)
    }
    
    /**
     We might want a JSON representation of this object, luckily, Codable to the rescue!
     - parameter data: The data returned representing the JSON feed.
     */
    static func data(exercises: [ExerciseEvent]) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(exercises)
    }
}
