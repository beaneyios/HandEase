//
//  ImageDownloaderFactory.swift
//  HandEase
//
//  Created by Matt Beaney on 15/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class ImageDownloaderFactory: ImageDownloaderCreating {
    func imageDownloader() -> ImageDownloader {
        let getter = NetworkGetter()
        let cacher = Cacher(ttlManager: TTLManager())
        return ImageDownloader(getter: getter, cacher: cacher)
    }
}
