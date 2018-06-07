//
//  ContainerNavigationBarViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 07/06/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class ContainerNavigationBarViewController: UIViewController {
    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var container: UIView!
    
    private var menuFlowController  : MenuOpening!
    private var childViewController : UIViewController!
    private var strTitle            : String!
    
    func configure(menuFlowController: MenuOpening, childViewController: UIViewController, strTitle: String) {
        self.menuFlowController     = menuFlowController
        self.childViewController    = childViewController
        self.strTitle               = strTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationTitle.text = self.strTitle
        
        self.addChild(childViewController)
        self.container.addSubview(childViewController.view)
        self.container.fixSizeToContainer(subview: childViewController.view)
    }
}

extension ContainerNavigationBarViewController: MenuOpening {
    func toggleMenu() {
        self.menuFlowController.toggleMenu()
    }

    @IBAction func openMenu(_ sender: Any) {
        self.toggleMenu()
    }
}
