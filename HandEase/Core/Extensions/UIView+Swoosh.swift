//
//  UIView+Swoosh.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

typealias SelectionCompletion = () -> ()

extension UIView {
    
    /**
     An extension that takes inspiration from Google Material design, adding a nicer touch event to a given UIView.
     - parameter parent: the view into which the animation should be placed.
     - parameter sender: The tap gesture recogniser, used to determine the position of the touch.
     - parameter duration: Allows user to decide how long the animation lasts.
     - parameter tintColor: Allows user to define tintColor.
     - parameter completion: The code that should run after the animation is complete.
     */
    func select(parent: UIView, sender: UITapGestureRecognizer, duration: Float? = 0.5, tintColor: UIColor = .white, completion: @escaping SelectionCompletion) {
        let location = sender.location(ofTouch: 0, in: parent)
        let alerter = UIView()
        alerter.backgroundColor = tintColor
        alerter.layer.cornerRadius = 10.0
        alerter.clipsToBounds = true
        alerter.frame = CGRect(x: location.x, y: location.y, width: 20.0, height: 20.0)
        alerter.center = location
        alerter.alpha = 0.3
        parent.addSubview(alerter)
        parent.clipsToBounds = true
        
        UIView.animate(withDuration: 0.5, animations: {
            alerter.transform = CGAffineTransform(scaleX: 100.0, y: 100.0)
        }) { (finished) in
            UIView.animate(withDuration: 0.3, animations: {
                alerter.alpha = 0.0
            })
        }
        
        let when = DispatchTime.now() + TimeInterval(((duration ?? 0.5) - 0.4))
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion()
        }
    }
}
