//
//  DependencyFactories.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class CacherFactory: CacherCreating {
    func cacher() -> Cacher {
        return Cacher(ttlManager: TTLManager())
    }
}

class ContainerFactory: ContainerCreating {
    func container(flowController: ExerciseFlowController, menuDelegate: MenuHandler) -> SlideMenuExerciseContainer? {
        guard let container = ViewControllers.container as? ContainerViewController else {
            return nil
        }
        
        container.configure(flowController: flowController, menuDelegate: menuDelegate)
        return container
    }
}

class ImageDownloaderFactory: ImageDownloaderCreating {
    func imageDownloader() -> ImageDownloader {
        let getter = NetworkGetter()
        let cacher = Cacher(ttlManager: TTLManager())
        return ImageDownloader(getter: getter, cacher: cacher)
    }
}
