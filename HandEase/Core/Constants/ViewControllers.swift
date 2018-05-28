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
    static var myExercises   = StoryboardRepresentation(sbName: "Exercises", sbIdentifier: "myExercises")
    static var allExercises  = StoryboardRepresentation(sbName: "Exercises", sbIdentifier: "allExercises")
    static var remindMe      = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var progress      = StoryboardRepresentation(sbName: "Progress", sbIdentifier: "progress")
    static var leaflets      = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var donate        = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var about         = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var menu          = StoryboardRepresentation(sbName: "Menu", sbIdentifier: "menu")
    static var container     = StoryboardRepresentation(sbName: "Container", sbIdentifier: "homeContainer")
    static var exercise      = StoryboardRepresentation(sbName: "Exercises", sbIdentifier: "exercise")
    static var video         = StoryboardRepresentation(sbName: "Exercises", sbIdentifier: "video")
}

extension StoryboardRepresentation: Equatable {
    static func == (lhs: StoryboardRepresentation, rhs: StoryboardRepresentation) -> Bool {
        return  lhs.sbIdentifier == rhs.sbIdentifier && lhs.sbName == rhs.sbName
    }
}

//TODO: I'm force-unwrapping here, so we need to write tests to be absolutely sure they exist.
struct ViewControllers {
    static var myExercises  : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.myExercises)! }
    static var allExercises : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.allExercises)! }
    static var remindMe     : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.remindMe)! }
    static var progress     : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.progress)! }
    static var leaflets     : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.leaflets)! }
    static var donate       : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.donate)! }
    static var about        : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.about)! }
    static var menu         : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.menu)! }
    static var container    : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.container)! }
    static var exercise     : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.exercise)! }
    static var video        : UIViewController { return UIStoryboard.viewController(for: ViewControllerRepresentations.video)! }
}

struct StoryboardRepresentation {
    let sbName              : String
    let sbIdentifier        : String
}
