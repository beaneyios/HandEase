//
//  LocalMenuItemSizer.swift
//  HandEase
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

protocol MenuItemSizer {
    func size(for menuItem: MenuItem, container: UIView) -> CGSize
}
