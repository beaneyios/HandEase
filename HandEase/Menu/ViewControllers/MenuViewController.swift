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
    
    var vm: MenuViewModel = {
        return DefaultMenuViewModel(
            sizer: LocalMenuItemSizer(),
            dataSource: LocalMenuItemDataSource()
        )
    }()
    
    public func configure(with vm: MenuViewModel) {
        self.vm = vm
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vm.bind(cview: cview)
    }
}
