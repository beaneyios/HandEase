//
//  MenuItemViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

protocol MenuItemViewModel {
    var strTitle: String    { get }
    var imgIcon: UIImage?   { get }
    var foreColor: UIColor  { get }
    var backColor: UIColor  { get }
    var action: ItemAction  { get }
}
