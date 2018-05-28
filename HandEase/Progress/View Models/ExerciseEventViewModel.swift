//
//  ExerciseEventViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 28/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

struct ExerciseEventViewModel: EventViewModel, ExerciseImageDownloading {
    private var exerciseEvent: ExerciseEvent
    private var dependencies: Dependencies
    private var imageDownloader: ImageDownloading { return self.dependencies.imageDownloader }
    private var tracker: ExerciseTracking { return self.dependencies.tracker }
    
    typealias Dependencies = HasImageDownloader & HasExerciseTracker
    
    init(exerciseEvent: ExerciseEvent, dependencies: Dependencies) {
        self.exerciseEvent = exerciseEvent
        self.dependencies = dependencies
    }
    
    var eventCount: String {
        let number = self.tracker.numberOfTracksForGivenExercise(exercise: self.exerciseEvent.exercise)
        return "You have completed this exercise \(number) times"
    }
    
    var lastCompleted: String {
        let date = self.exerciseEvent.date
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dateString = df.string(from: date)
        return "Last completed: \(dateString)"
    }
    
    var titleLabel: String {
        return exerciseEvent.exercise.title
    }
    
    func image(completion: @escaping ImageCompletion) {
        self.imageDownloader.cancelDownload()
        
        guard let url = URL(string: self.exerciseEvent.exercise.imageURL) else { return }
        self.imageDownloader.downloadImage(url: url, defaultImage: nil) { (result) in
            self.handleImageResult(result: result, completion: completion)
        }
    }
    
    struct Config: Dependencies {
        var imageDownloader: ImageDownloading
        var tracker: ExerciseTracking
    }
}
