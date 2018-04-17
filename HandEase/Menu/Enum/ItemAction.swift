//
//  ItemAction.swift
//  HandEase
//
//  Created by Matt Beaney on 17/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

enum ItemAction {
    case loadView(viewController: StoryboardRepresentation)
}

struct ViewControllers {
    static var myExercises      = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var allExercises     = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var remindMe         = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var progress         = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var leaflets         = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var donate           = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    static var about            = StoryboardRepresentation(sbName: "", sbIdentifier: "")
    
}

struct StoryboardRepresentation {
    let sbName          : String
    let sbIdentifier    : String
}
