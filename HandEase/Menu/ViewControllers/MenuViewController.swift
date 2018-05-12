//
//  MenuViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    @IBOutlet weak var cview: UICollectionView!
    
    var vm: MenuViewModel!
    
    public func configure(with vm: MenuViewModel) {
        self.vm = vm
    }
    
    override func viewDidLoad() {
        self.cview.contentInsetAdjustmentBehavior = .never
        self.view.backgroundColor = self.vm.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vm.bind(cview: cview)
    }
}
