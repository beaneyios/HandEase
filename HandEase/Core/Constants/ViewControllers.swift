//
//  ViewControllers.swift
//  HandEase
//
//  Created by Matt Beaney on 29/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

struct ViewControllerRepresentations {
    static var myExercises      = StoryboardRepresentation(sbName: "Exercises", sbIdentifier: "exercises")
    static var allExercises     = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var remindMe         = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var progress         = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var leaflets         = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var donate           = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var about            = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var menu             = StoryboardRepresentation(sbName: "Main", sbIdentifier: "menu")
}

//TODO: I'm force-unwrapping here, so we need to write tests to be absolutely sure they exist.
struct ViewControllers {
    static var myExercises      = UIStoryboard.viewController(for: ViewControllerRepresentations.myExercises)!
    static var allExercises     = UIStoryboard.viewController(for: ViewControllerRepresentations.allExercises)!
    static var remindMe         = UIStoryboard.viewController(for: ViewControllerRepresentations.remindMe)!
    static var progress         = UIStoryboard.viewController(for: ViewControllerRepresentations.progress)!
    static var leaflets         = UIStoryboard.viewController(for: ViewControllerRepresentations.leaflets)!
    static var donate           = UIStoryboard.viewController(for: ViewControllerRepresentations.donate)!
    static var about            = UIStoryboard.viewController(for: ViewControllerRepresentations.about)!
    static var menu             = UIStoryboard.viewController(for: ViewControllerRepresentations.menu)!
}

struct StoryboardRepresentation {
    let sbName          : String
    let sbIdentifier    : String
}
