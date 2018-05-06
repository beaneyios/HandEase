//
//  ExerciseFetcher.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

class ExerciseFetcher: ExerciseFetching {
    func fetchExercises(completion: @escaping ExerciseFetchCompletion) {
        let url = URL(string: "https://s3-eu-west-1.amazonaws.com/handease/exercises/test.json")!
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            let exercises = try! decoder.decode([Exercise].self, from: data!)
            completion(exercises)
        }
        
        dataTask.resume()
    }
}
