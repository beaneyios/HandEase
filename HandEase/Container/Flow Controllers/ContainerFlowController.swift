//
//  ContainerFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 01/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBNetworking

typealias SlideMenuExerciseContainer = ViewControllerContaining & MenuOpening

class ContainerFlowController: ExerciseFlowController {
    typealias Dependencies =    HasImageDownloaderFactory       &
                                HasContainerFactory             &
                                HasMenuFlowControllerFactory    &
                                HasExerciseListViewModelFactory
    private var dependencies: Dependencies
    
    struct Config: Dependencies {
        var menuHandlerFactory              : MenuFlowControllerFactory
        var imageDownloaderFactory          : ImageDownloaderCreating
        var containerFactory                : ContainerCreating
        var exerciseListViewModelFactory    : ListViewModelCreating
    }
    
    var navigationController: UINavigationController!
    
    private var menuHandler: MenuHandler!
    private var containerVC: SlideMenuExerciseContainer!
    private var rootVC: StoryboardRepresentation
    
    init(rootVC: StoryboardRepresentation, dependencies: Dependencies) {
        self.dependencies = dependencies
        self.rootVC = rootVC
        
        self.menuHandler = dependencies.menuHandlerFactory.menuFlowController(parent: self)
        self.containerVC = dependencies.containerFactory.container(flowController: self, menuDelegate: self.menuHandler)
        
        if let container = self.containerVC as? UIViewController {
            let navigationController = UINavigationController(rootViewController: container)
            navigationController.setNavigationBarHidden(true, animated: false)
            self.navigationController = navigationController
        }
    }
    
    /**
     Starts the navigation.
    */
    func setRootViewController() {
        self.navigate(to: self.rootVC)
    }
    
    /**
     Generic routing that will blindly open a storyboard backed VC.
     Navigation in this view controller really means "setting" the VC in the container view.
     Unless it's a menu, in which case it will toggle the menu, rather than "set" it.
     This is to allow the slide out menu.
     - parameter vc: The storyboard representation.
    */
    func navigate(to vc: StoryboardRepresentation) {
        if vc == ViewControllerRepresentations.menu {
            self.containerVC.toggleMenu()
            return
        }
        
        guard let exerciseViewController     = UIStoryboard.viewController(for: vc) else { return }
        guard let navContainerViewController = ViewControllers.containerNav as? ContainerNavigationBarViewController else { return }
        
        if let exercises = exerciseViewController as? ListConfigurable {
            var navTitle = ""
            
            switch vc {
            case ViewControllerRepresentations.allExercises:
                let viewModel = self.fetchAllExerciseListViewModel()
                exercises.configure(viewModel: viewModel)
                navTitle = LocalisedKey.titleAllExercises.localisedString
            case ViewControllerRepresentations.myExercises:
                let viewModel = self.fetchMyExerciseListViewModel()
                exercises.configure(viewModel: viewModel)
                navTitle = LocalisedKey.titleMyExercises.localisedString
            case ViewControllerRepresentations.progress:
                let viewModel = self.fetchProgressListViewModel()
                exercises.configure(viewModel: viewModel)
                navTitle = LocalisedKey.titleProgress.localisedString
            default:
                let viewModel = self.fetchAllExerciseListViewModel()
                exercises.configure(viewModel: viewModel)
                navTitle = LocalisedKey.titleAllExercises.localisedString
            }
            
            navContainerViewController.configure(menuFlowController: self.menuHandler,
                                                 childViewController: exerciseViewController,
                                                 strTitle: navTitle)
        }
        
        self.setViewControllerOnContainer(viewController: navContainerViewController)
    }
    
    private func setViewControllerOnContainer(viewController: UIViewController) {
        let setClosure = { (_ viewController: UIViewController) in
            self.containerVC.setCurrentViewController(viewController: viewController)
        }
        
        switch viewController {
        case let viewController as ExerciseListViewController:
            
            setClosure(viewController)
            break
        default:
            setClosure(viewController)
            break
        }
    }
    
    private func fetchAllExerciseListViewModel() -> ListViewModel {
        return self.dependencies.exerciseListViewModelFactory.allExercisesViewModel(navigator: self)
    }
    
    private func fetchMyExerciseListViewModel() -> ListViewModel {
        return self.dependencies.exerciseListViewModelFactory.myExercisesViewModel(navigator: self)
    }
    
    private func fetchProgressListViewModel() -> ListViewModel {
        return self.dependencies.exerciseListViewModelFactory.progressListViewModel(navigator: self)
    }
}
