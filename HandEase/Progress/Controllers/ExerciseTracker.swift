//
//  ExerciseTracker.swift
//  HandEase
//
//  Created by Matt Beaney on 20/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class ExerciseTracker: ExerciseTracking {
    private var cacheType: String = "progress"
    private var secondsTTL: Int { return 60 * 60 * 24 * 1000 } //24 hours cache right now.
    private var trackedExercises: [ExerciseEvent] = [ExerciseEvent]()
    private var cacheURL: URL? = URL(string: "mb://progress")
    
    typealias Dependencies = HasCacher
    private var dependencies: Dependencies
    
    struct Config: Dependencies {
        var cacher: Cacheable
    }
    
    private var cacher: Cacheable { return self.dependencies.cacher }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.synchronize()
    }
    
    func fetchTrackedExercises() -> [ExerciseEvent] {
        return self.trackedExercises
    }
    
    func trackExerciseCompleted(exercise: Exercise) {
        var exercises = self.fetchProgressFromCache()
        
        let exerciseEvent = ExerciseEvent(exercise: exercise)
        exercises.append(exerciseEvent)
        
        guard let json = ExerciseEvent.data(exercises: exercises), let url = cacheURL else { return }
        
        cacher.set(url: url, data: json, secondsTTL: secondsTTL, type: cacheType)
        self.synchronize()
    }
    
    func numberOfTracksForGivenExercise(exercise: Exercise) -> Int {
        let exerciseEvents = self.fetchProgressFromCache()
        let matchedExercises = exerciseEvents.filter {
            $0.exercise == exercise
        }
        
        return matchedExercises.count
    }
    
    private func synchronize() {
        self.trackedExercises = self.fetchProgressFromCache()
    }
    
    private func fetchProgressFromCache() -> [ExerciseEvent] {
        guard
            let url = cacheURL,
            case DownloadResult.success(data: let data, response: _) = cacher.get(url: url, type: cacheType),
            let exercises = ExerciseEvent.parseJSON(data: data)
            else {
                return []
        }
        
        return exercises
    }
}
