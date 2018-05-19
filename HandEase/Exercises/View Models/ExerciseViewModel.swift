//
//  ExerciseViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCompletion = (_ image: UIImage?) -> Void

class ExerciseViewModel {
    private var exercise: Exercise
    
    private var dependencies: Dependencies
    private var imageDownloader: ImageDownloading { return self.dependencies.imageDownloader }
    private var favouriter: ExerciseFetching & ExerciseFavouriting { return self.dependencies.favouriter }
    
    typealias Dependencies = HasImageDownloader & HasExerciseFavouriter
    
    init(exercise: Exercise, dependencies: Dependencies) {
        self.exercise = exercise
        self.dependencies = dependencies
    }
    
    var titleLabel: String { return exercise.title }
    var body: String { return exercise.body }
    var imageUrl: URL? { return URL(string: self.exercise.imageURL) }
    var videoURL: URL? { return URL(string: self.exercise.videoURL) }
    var isFavourited: Bool { return self.favouriter.isFavourite(exercise: self.exercise) }
    
    func image(completion: @escaping ImageCompletion) {
        self.imageDownloader.cancelDownload()
        
        guard let url = URL(string: self.exercise.imageURL) else { return }
        self.imageDownloader.downloadImage(url: url, defaultImage: nil) { (result) in
            self.handleImageResult(result: result, completion: completion)
        }
    }
    
    func favourite() -> Bool {
        return self.favouriter.favourite(exercise: self.exercise)
    }
    
    private func handleImageResult(result: ImageResult, completion: @escaping ImageCompletion) {
        switch result {
        case .successful(image: let image):
            completion(image)
        case .failure(error: let error, defaultImage: let image):
            //TODO: Handle error logging.
            print(error)
            completion(image)
        }
    }
    
    struct Config: Dependencies {        
        var favouriter: ExerciseFavouriting & ExerciseFetching
        var imageDownloader: ImageDownloading
    }
}
