//
//  UIViewController+AddChildViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 29/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addChild(_ childViewController: UIViewController) {
        childViewController.willMove(toParentViewController: self)
        self.addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
    }
}
