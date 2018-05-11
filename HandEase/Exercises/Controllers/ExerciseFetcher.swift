//
//  ExerciseFetcher.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class ExerciseFetcher: ExerciseFetching {
    var getter: Getter
    
    init(getter: Getter) {
        self.getter = getter
    }
    
    func fetchExercises(completion: @escaping ExerciseFetchCompletion) {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/handease/exercises/test.json") else {
            return
        }
        
        _ = self.getter.get(url: url, timeout: 10.0) { (result) in
            self.handleResult(result: result, completion: completion)
        }
    }
    
    private func handleResult(result: DownloadResult, completion: @escaping ExerciseFetchCompletion) {
        switch result {
        case .success(data: let data, response: let response):
            self.handleSuccess(data: data, response: response, completion: completion)
        case .failure(error: let error):
            self.handleFailure(error: error, completion: completion)
        }
    }
    
    private func handleSuccess(data: Data, response: HTTPURLResponse, completion: @escaping ExerciseFetchCompletion) {
        let decoder = JSONDecoder()
        guard let exercises = try? decoder.decode([Exercise].self, from: data) else {
            //TODO: Error handling.
            return
        }
        
        let result = ExerciseResult.success(exercises: exercises)
        completion(result)
    }
    
    private func handleFailure(error: Error?, completion: @escaping ExerciseFetchCompletion) {
        //TODO: Error handling.
    }
}
