//
//  TestViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 17/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class TestViewController : UIViewController {
    @IBAction func openMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let menu = storyboard.instantiateViewController(withIdentifier: "menu") as? MenuViewController {
            let menuVM = DefaultMenuViewModel(sizer: LocalMenuItemSizer(), dataSource: LocalMenuItemDataSource())
            menu.vm = menuVM
            
            menuVM.bind { (action) in
                print(action)
            }
            
            menu.willMove(toParentViewController: self)
            self.view.addSubview(menu.view)
            self.addChildViewController(menu)
            menu.didMove(toParentViewController: self)
        }
    }
}
