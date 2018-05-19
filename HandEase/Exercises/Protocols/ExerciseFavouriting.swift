//
//  ExerciseFavouriting.swift
//  HandEase
//
//  Created by Matt Beaney on 19/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

protocol ExerciseFavouriting {
    func isFavourite(exercise: Exercise) -> Bool
    func favourite(exercise: Exercise) -> Bool
}
