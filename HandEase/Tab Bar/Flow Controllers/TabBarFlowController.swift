//
//  TabBarFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 08/06/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class TabBarFlowController: ExerciseFlowController {
    typealias Dependencies =    HasImageDownloaderFactory       &
                                HasExerciseListViewModelFactory
    private var dependencies: Dependencies
    
    struct Config: Dependencies {
        var imageDownloaderFactory          : ImageDownloaderCreating
        var exerciseListViewModelFactory    : ListViewModelCreating
    }
    
    var navigationController: UINavigationController!
    
    private var tabBar: UITabBarController
    
    init(dependencies: Dependencies) {
        self.tabBar         = UITabBarController()
        self.dependencies   = dependencies
        self.setRootViewController()
    }
        
    func setRootViewController() {
        let allExercisesVC  = ViewControllers.allExercises
        allExercisesVC.tabBarItem = UITabBarItem(title: "All Exercises", image: UIImage(type: .tabDoublePageIcon), selectedImage: nil)
        
        let myExercisesVC   = ViewControllers.myExercises
        myExercisesVC.tabBarItem = UITabBarItem(title: "My Exercises", image: UIImage(type: .tabHeartIcon), selectedImage: nil)
        
        let progressVC      = ViewControllers.progress
        progressVC.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(type: .tabPersonIcon), selectedImage: nil)
        
        guard   let allExercisesList    = allExercisesVC as? ListConfigurable,
                let myExercisesList     = myExercisesVC as? ListConfigurable,
                let progressList        = progressVC as? ListConfigurable
        else
        {
            return
        }
        
        let allExercisesViewModel = dependencies.exerciseListViewModelFactory.allExercisesViewModel(navigator: self)
        allExercisesList.configure(viewModel: allExercisesViewModel)

        let myExercisesViewModel = dependencies.exerciseListViewModelFactory.myExercisesViewModel(navigator: self)
        myExercisesList.configure(viewModel: myExercisesViewModel)
        
        let progressViewModel = dependencies.exerciseListViewModelFactory.progressListViewModel(navigator: self)
        progressList.configure(viewModel: progressViewModel)
        
        self.tabBar.viewControllers = [allExercisesVC, myExercisesVC, progressVC]
        
        let navigationController = UINavigationController(rootViewController: self.tabBar)
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController = navigationController
    }
    
    func navigate(to vc: StoryboardRepresentation) {
        
    }
}
