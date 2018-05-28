//
//  ExerciseImageDownloading.swift
//  HandEase
//
//  Created by Matt Beaney on 28/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

protocol ExerciseImageDownloading {
    func handleImageResult(result: ImageResult, completion: @escaping ImageCompletion)
}

extension ExerciseImageDownloading {
    func handleImageResult(result: ImageResult, completion: @escaping ImageCompletion) {
        switch result {
        case .successful(image: let image):
            completion(image)
        case .failure(error: let error, defaultImage: let image):
            //TODO: Handle error logging.
            print(error)
            completion(image)
        }
    }
}
