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
    private var getter: Getter
    private var cacher: Cacheable
    
    private var host = "https://s3-eu-west-1.amazonaws.com"
    private var endPoint = "/handease/exercises/test.json"
    private var exercisesURL: URL? { return URL(string: host + endPoint) }
    
    private var fetchTask: URLSessionDataTaskProtocol?
    
    init(getter: Getter, cacher: Cacheable) {
        self.getter = getter
        self.cacher = cacher
    }
    
    /**
     The main entry point to fetching exercises
     - parameter  completion: The completion into which we either pass a user-pretty error or successful exercise lists.
    */
    func fetchExercises(completion: @escaping ExerciseFetchCompletion) {
        guard let url = self.exercisesURL else { return }
        
        self.fetchTask = self.getter.get(url: url, timeout: 10.0) { (result) in
            self.handleResult(url: url, result: result, completion: completion)
        }
    }
    
    /**
     If we build in some kind of refresh system, we may wish to cancel it. This provides an entry point to that cancellation.
    */
    func cancelFetch() {
        self.fetchTask?.cancel()
    }
    
    /**
     The main entry point into which we pass our download result, returned from MBNetworking.
     - parameter  url: The URL that we have attempted a download on.
     - parameter  result: The download result.
     - parameter  completion: The completion into which we either pass a user-pretty error or successful exercise lists.
    */
    private func handleResult(url: URL, result: DownloadResult, completion: @escaping ExerciseFetchCompletion) {
        switch result {
        case .success(data: let data, response: let response):
            self.handleSuccess(url: url, data: data, response: response, completion: completion)
        case .failure(error: let error):
            self.handleFailure(url: url, error: error, completion: completion)
        }
    }
    
    /**
     If the network request is successful, we need to do something with the data and response.
     - parameter  url: The URL that has succeeded in downloading
     - parameter  data: The unwrapped JSON data.
     - parameter  response: The HTTP response (currently unused).
     - parameter  completion: The completion into which we pass the finished list of exercises to display.
    */
    private func handleSuccess(url: URL, data: Data, response: HTTPURLResponse, completion: @escaping ExerciseFetchCompletion) {
        guard let exercises = self.parseJSON(data: data) else {
            let customError = CustomError(area: "com.handease.json", description: "There was an issue interpreting the exercises, please try again.", code: 500)
            let exerciseResult = ExerciseResult.failure(error: customError, defaultExercises: self.fetchCachedExercises(for: url))
            completion(exerciseResult)
            return
        }
        
        self.cacher.set(url: url, data: data)
        let result = ExerciseResult.success(exercises: exercises)
        completion(result)
    }
    
    /**
     Specifically handles networking failures from MBNetworking.
     - parameter  url: The URL that has failed to download.
     - parameter  error: An optional error from MBNetworking.
     - parameter  completion: The completion into which we pass our user-pretty error.
    */
    private func handleFailure(url: URL, error: Error?, completion: @escaping ExerciseFetchCompletion) {
        guard let error = error else {
            let customError = CustomError(area: "com.handease.download.unknown", description: "There was an issue downloading the exercises, please try again.", code: 500)
            let exerciseResult = ExerciseResult.failure(error: customError, defaultExercises: self.fetchCachedExercises(for: url))
            completion(exerciseResult)
            return
        }
        
        let nsError = error as NSError
        let customError = CustomError(area: nsError.domain, description: "There was an issue downloading the exercises, please try again.", code: nsError.code)
        let exerciseResult = ExerciseResult.failure(error: customError, defaultExercises: self.fetchCachedExercises(for: url))
        completion(exerciseResult)
    }
    
    /**
     Should any part of the exercises fetching fail, we need to at least try and provide some cached exercises.
     - parameter  url: This is the URL we have called and want to retrieve cached content for. A requirement for MBNetworking.
     -returns: An optional list of exercises.
    */
    private func fetchCachedExercises(for url: URL) -> [Exercise]? {
        guard case .success(data: let data, response: _) = cacher.get(url: url) else {
            return nil
        }
        
        return self.parseJSON(data: data)
    }
    
    /**
     Our feed is delivered via JSON, we need to be able to map this to an object.
     - parameter data: The data returned representing the JSON feed.
    */
    private func parseJSON(data: Data) -> [Exercise]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([Exercise].self, from: data)
    }
}
