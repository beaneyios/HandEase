//
//  ExerciseViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCompletion = (_ image: UIImage) -> Void

class DefaultExerciseViewModel {
    private var exercise: Exercise
    private var imageTask: URLSessionDataTask?
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    var titleLabel: String {
        return exercise.title
    }
    
    func image(completion: @escaping ImageCompletion) {
        self.imageTask?.cancel()
        guard let url = URL(string: self.exercise.imageURL) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        self.imageTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            completion(image)
        })
        
        self.imageTask?.resume()
    }
}
