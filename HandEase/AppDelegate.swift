//
//  AppDelegate.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var flowController: FlowController?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.rootViewController = self.fetchInitialViewController()
        self.window?.makeKeyAndVisible()
    }
    
    func fetchInitialViewController() -> UIViewController? {
        guard let container = ViewControllers.container as? ContainerViewController else {
            return nil
        }
        
        let navigation = UINavigationController(rootViewController: container)
        navigation.setNavigationBarHidden(true, animated: false)
        
        let flowController = ContainerFlowController(containerVC: container, navigationController: navigation)
        container.configure(flowController: flowController)
        self.flowController = flowController
        return navigation
    }    
}

