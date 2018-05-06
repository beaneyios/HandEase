//
//  LocalMenuItemSizer.swift
//  HandEase
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class LocalMenuItemSizer : MenuItemSizer {
    func size(for menuItem: MenuItem, container: UIView) -> CGSize {
        return CGSize(width: container.frame.size.width, height: 75.0)
    }
}
