//
//  ContainerFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 01/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

protocol ContainerFlowController: class {
    var container: HomeContainerViewController  { get }
    var navigation: UINavigationController      { get }
    
    func handleMenuAction(action: ItemAction)
}
