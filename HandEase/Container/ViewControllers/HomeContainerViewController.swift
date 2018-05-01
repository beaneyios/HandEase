//
//  TestViewController.swift
//  HandEase
//
//  Created by Matt Beaney on 17/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class HomeContainerViewController : UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerCenterX: NSLayoutConstraint!
    
    private var currentViewController: UIViewController?
    private weak var flowController: ContainerFlowController! {
        didSet {
            
        }
    }
    
    func configure(flowController: ContainerFlowController) {
        self.flowController = flowController
    }
    
    override func viewDidLoad() {
        self.setCurrentViewController(viewController: ViewControllers.myExercises)
        self.configureMenu()
    }
    
    func setCurrentViewController(viewController: UIViewController) {
        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParentViewController()
        
        self.currentViewController = viewController
        self.addChild(viewController)
        self.containerView.addSubview(viewController.view)
        self.containerView.fixSizeToContainer(subview: viewController.view)
    }
}

//MARK: MENU LOGIC
extension HomeContainerViewController {
    @IBAction func openMenu(_ sender: Any) {
        self.animateMenuOpen()
    }
    
    private func animateMenuOpen() {
        self.containerCenterX.constant = 250
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateMenuClosed() {
        self.containerCenterX.constant = 0
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureMenu() {
        guard let menu = ViewControllers.menu as? MenuViewController else { return }
        
        let menuVM = DefaultMenuViewModel(sizer: LocalMenuItemSizer(),
                                          dataSource: LocalMenuItemDataSource(),
                                          theme: LocalMenuTheme())
        menu.vm = menuVM
        
        menuVM.bind { (action) in
            self.animateMenuClosed()
            self.flowController.handleMenuAction(action: action)
        }
        
        self.addChild(menu)
        self.view.addSubview(menu.view)
        menu.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menu.view.rightAnchor.constraint(equalTo: self.containerView.leftAnchor),
            menu.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            menu.view.widthAnchor.constraint(equalToConstant: 250.0),
            menu.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.containerView.addGestureRecognizer(pan)
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            break
        case .changed:
            let endPoint = self.containerCenterX.constant + recognizer.translation(in: view).x
            defer { recognizer.setTranslation(CGPoint.zero, in: view) }
            
            if endPoint < 0 {
                self.containerCenterX.constant = 0
                return
            }
            
            if endPoint > 250 {
                self.containerCenterX.constant = 250.0
                return
            }
            
            self.containerCenterX.constant = endPoint
        case .ended:
            if self.containerCenterX.constant > 125 {
                self.animateMenuOpen()
            } else {
                self.animateMenuClosed()
            }
        default:
            break
        }
    }
}
