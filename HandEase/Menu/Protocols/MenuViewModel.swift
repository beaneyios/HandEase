//
//  MenuViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

typealias MenuItemActionClosure = (_ action: ItemAction) -> ()

protocol MenuViewModel {
    var action: MenuItemActionClosure? { get set }
    var backgroundColor: UIColor { get }
    func bind(cview: UICollectionView)
}
