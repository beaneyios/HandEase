//
//  ImageDownloading.swift
//  HandEase
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBNetworking

enum ImageResult {
    case successful(image: UIImage)
    case failure(error: CustomError, defaultImage: UIImage?)
}

typealias ImageDownloadCompletion = (_ result: ImageResult) -> Void

protocol ImageDownloading {
    func downloadImage(url: URL, defaultImage: UIImage?, completion: @escaping ImageDownloadCompletion)
    func cancelDownload()
}
