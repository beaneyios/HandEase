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
    var flowController: ExerciseFlowController?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.rootViewController = self.fetchInitialViewController()
        self.window?.makeKeyAndVisible()
    }
    
    func fetchInitialViewController() -> UIViewController? {
        let config = ContainerFlowController.Config(menuHandlerFactory          : MenuFlowControllerFactory(),
                                                    exerciseFetcherFactory      : ExerciseFetcherFactory(),
                                                    imageDownloaderFactory      : ImageDownloaderFactory(),
                                                    containerFactory            : ContainerFactory(),
                                                    exerciseFavouriterFactory   : ExerciseFavouriterFactory(),
                                                    exerciseListViewModelFactory: ExerciseListViewModelFactory())
        
        let containerFlowController = ContainerFlowController(dependencies: config)
        containerFlowController.configure()
        
        self.flowController = containerFlowController
        return containerFlowController.navigationController
    }    
}

