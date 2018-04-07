//
//  UIImage+ImageType.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(type: ImageType) {
        self.init(named: type.stringlyTypedImage)
    }
}
