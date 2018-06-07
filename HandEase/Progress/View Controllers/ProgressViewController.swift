//
//  ProgressViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 20/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class ProgressViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var menuFlowController  : MenuOpening!
    private var viewModel           : ListViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.bind(cview: self.collectionView)
    }
}

extension ProgressViewController: ListConfigurable {
    func configure(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
}

extension ProgressViewController: MenuOpening {
    func toggleMenu() {
        self.menuFlowController.toggleMenu()
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        self.toggleMenu()
    }
}

