//
//  ContainerFlowController.swift
//  HandEase
//
//  Created by Matt Beaney on 01/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

typealias SlideMenuExerciseContainer = ViewControllerContaining & MenuOpening

class ContainerFlowController: ExerciseFlowController {
    private var dependencies: Dependencies
    
    var navigationController: UINavigationController!
    
    private var menuHandler: MenuHandler!
    private var containerVC: SlideMenuExerciseContainer!    
    
    typealias Dependencies = HasImageDownloaderFactory & HasExerciseFetcherFactory & HasContainerFactory & HasMenuFlowControllerFactory & HasExerciseFavouriterFactory
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func configure() {
        self.menuHandler = dependencies.menuHandlerFactory.menuFlowController(parent: self)
        self.containerVC = dependencies.containerFactory.container(flowController: self, menuDelegate: self.menuHandler)
        
        if let container = self.containerVC as? UIViewController {
            let navigationController = UINavigationController(rootViewController: container)
            navigationController.setNavigationBarHidden(true, animated: false)
            self.navigationController = navigationController
        }
    }
    
    /**
     Handles opening a specific exercise.
     - parameter exercise: The view model representing the exercise itself.
    */
    func exerciseTapped(exercise: ExerciseViewModel) {
        guard let vc = ViewControllers.exercise as? ExerciseViewController else { return }
        vc.configure(flowController: self, exercise: exercise)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    /**
     Handles opening a specific exercise video.
     - parameter exercise: The view model representing the exercise itself.
    */
    func exerciseVideoTapped(exercise: ExerciseViewModel) {
        guard let vc = ViewControllers.video as? ExerciseVideoViewController else { return }
        vc.configure(exercise: exercise, flowController: self)
        self.navigationController.pushViewController(vc, animated: true)
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
        
        guard let viewController = UIStoryboard.viewController(for: vc) else { return }
        
        if let exercises = viewController as? ExerciseListViewController {
            switch vc {
            case ViewControllerRepresentations.allExercises:
                let viewModelConfig = self.fetchAllExerciseListDependencies()
                let viewModel = ExerciseListViewModel(dependencies: viewModelConfig)
                exercises.configure(menuFlowController: self.menuHandler, viewModel: viewModel)
            case ViewControllerRepresentations.myExercises:
                let viewModelConfig = self.fetchMyExerciseListDependencies()
                let viewModel = ExerciseListViewModel(dependencies: viewModelConfig)
                exercises.configure(menuFlowController: self.menuHandler, viewModel: viewModel)
            default:
                let viewModelConfig = self.fetchAllExerciseListDependencies()
                let viewModel = ExerciseListViewModel(dependencies: viewModelConfig)
                exercises.configure(menuFlowController: self.menuHandler, viewModel: viewModel)
            }
        }
        
        self.setViewControllerOnContainer(viewController: viewController)
    }
    
    /**
     Whatever view sits on top of the stack, this will close it.
    */
    func closeCurrentVC(viewController: UIViewController) {
        self.navigationController.popViewController(animated: true)
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
    
    private func fetchAllExerciseListDependencies() -> ExerciseListViewModel.Config {
        let fetcher                 = self.dependencies.exerciseFetcherFactory.exerciseFetcher()
        let imageDownloaderFactory  = self.dependencies.imageDownloaderFactory
        let favouriterFactory       = self.dependencies.exerciseFavouriterFactory
        return ExerciseListViewModel.Config(exerciseFetcher: fetcher,
                                            navigator: self,
                                            imageDownloaderFactory: imageDownloaderFactory,
                                            favouriter: favouriterFactory.exerciseFavouriter())
    }
    
    private func fetchMyExerciseListDependencies() -> ExerciseListViewModel.Config {
        let imageDownloaderFactory  = self.dependencies.imageDownloaderFactory
        let favouriter              = self.dependencies.exerciseFavouriterFactory.exerciseFavouriter()
        return ExerciseListViewModel.Config(exerciseFetcher: favouriter,
                                            navigator: self,
                                            imageDownloaderFactory: imageDownloaderFactory,
                                            favouriter: favouriter)
    }
    
    struct Config: Dependencies {
        var menuHandlerFactory      : MenuFlowControllerFactory
        var exerciseFetcherFactory  : ExerciseFetcherCreating
        var imageDownloaderFactory  : ImageDownloaderCreating
        var containerFactory        : ContainerCreating
        var exerciseFavouriterFactory: ExerciseFavouriterCreating
    }
}
