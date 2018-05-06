//
//  UIView+AutoLayoutHelpers.swift
//  HandEase
//
//  Created by Matt Beaney on 29/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fixSizeToContainer(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let subviews = ["subview": subview]
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: [], metrics: nil, views: subviews)
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: [], metrics: nil, views: subviews)
        self.addConstraints(horizontal)
        self.addConstraints(vertical)
    }
}
