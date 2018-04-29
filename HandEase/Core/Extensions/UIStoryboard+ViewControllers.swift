//
//  UIStoryboard+ViewControllers.swift
//  HandEase
//
//  Created by Matt Beaney on 29/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func viewController(for representation: StoryboardRepresentation) -> UIViewController? {
        let storyboard = UIStoryboard(name: representation.sbName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: representation.sbIdentifier)
    }
}
