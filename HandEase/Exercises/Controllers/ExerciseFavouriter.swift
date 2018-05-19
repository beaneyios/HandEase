//
//  ExerciseFavouriter.swift
//  HandEase
//
//  Created by Matt Beaney on 19/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class ExerciseFavouriter: ExerciseFetching {
    private var cacheType: String = "favourites"
    private var secondsTTL: Int { return 60 * 60 * 24 * 1000 } //24 hours cache right now.
    private var favourites: [Exercise] = [Exercise]()
    private var cacheURL: URL? = URL(string: "mb://favourites")
    
    
    typealias Dependencies = HasCacher
    private var dependencies: Dependencies
    private var cacher: Cacheable { return self.dependencies.cacher }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.synchronize()
    }
    
    func fetchExercises(force: Bool, completion: @escaping ExerciseFetchCompletion) {
        completion(.success(exercises: favourites))
    }
    
    private func synchronize() {
        self.favourites = self.fetchExercisesFromCache()
    }
    
    private func fetchExercisesFromCache() -> [Exercise] {
        guard
            let url = cacheURL,
            case DownloadResult.success(data: let data, response: _) = cacher.get(url: url, type: cacheType),
            let exercises = Exercise.parseJSON(data: data)
        else {
            return []
        }
        
        return exercises
    }
    
    struct Config: Dependencies {
        var cacher: Cacheable
    }
}

extension ExerciseFavouriter: ExerciseFavouriting {
    func isFavourite(exercise: Exercise) -> Bool {
        return favourites.contains(exercise)
    }
    
    func favourite(exercise: Exercise) -> Bool {
        var exercises = self.fetchExercisesFromCache()
        
        if let index = exercises.index(of: exercise) {
            exercises.remove(at: index)
        } else {
            exercises.append(exercise)
        }
        
        guard let json = Exercise.data(exercises: exercises), let url = cacheURL else {
            return false
        }
        
        cacher.set(url: url, data: json, secondsTTL: secondsTTL, type: cacheType)
        self.synchronize()
        return true
    }
}
