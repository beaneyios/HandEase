//
//  ImageDownloader.swift
//  HandEase
//
//  Created by Matt Beaney on 12/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import MBNetworking

class ImageDownloader: ImageDownloading {
    private var getter: Getter
    private var cacher: Cacheable
    
    private var cacheType: String = "images"
    private var secondsTTL: Int { return 60*60*24 }
    private var imageDownloadTask: URLSessionDataTaskProtocol?
    
    init(getter: Getter, cacher: Cacheable) {
        self.getter = getter
        self.cacher = cacher
    }
    
    /**
     The main entry point into the class, this allows you to download an image.
     - parameter url: The URL for the image in question.
     - parameter defaultImage: An optional default image to return in the event of an error.
     - parameter completion: The completion into which we'll pass a user-pretty error or an image.
    */
    func downloadImage(url: URL, defaultImage: UIImage? = nil, completion: @escaping ImageDownloadCompletion) {
        DispatchQueue.global().async {
            if self.shouldImageFromCache(url: url) {
                if let cachedImage = self.fetchCachedImage(url: url) {
                    completion(ImageResult.successful(image: cachedImage))
                    return
                }
            }
            
            self.imageDownloadTask = self.getter.get(url: url, timeout: 60.0) { (result) in
                self.handleResult(url: url, result: result, defaultImage: defaultImage, completion: completion)
            }
        }
    }
    
    /**
     This may be used in collection view cells, to avoid re-use issues, call this to cancel the requests.
     */
    func cancelDownload() {
        self.imageDownloadTask?.cancel()
    }
    
    /**
     If we have an in-date cache, no need to download.
     - returns: A boolean determing if we should or should not download.
     */
    private func shouldImageFromCache(url: URL) -> Bool {
        return self.cacher.cacheInDate(url: url, type: self.cacheType)
    }
    
    /**
     The main entry point into which we pass our download result, returned from MBNetworking.
     - parameter url: The URL that we have attempted a download on.
     - parameter result: The download result.
     - parameter completion: The completion into which we either pass a user-pretty error or an image.
     */
    private func handleResult(url: URL, result: DownloadResult, defaultImage: UIImage? = nil, completion: @escaping ImageDownloadCompletion) {
        switch result {
        case .success(data: let data, response: _):
            self.handleSuccess(url: url, data: data, defaultImage: defaultImage, completion: completion)
            self.cacher.set(url: url, data: data, secondsTTL: self.secondsTTL, type: self.cacheType)
        case .failure(error: let error):
            self.handleFailure(url: url, error: error, defaultImage: defaultImage, completion: completion)
        }
    }
    
    /**
     If the network request is successful, we need to do something with the data and response.
     - parameter url: The URL that has succeeded in downloading
     - parameter data: The unwrapped image data.
     - parameter completion: The completion into which we pass the image.
     */
    private func handleSuccess(url: URL, data: Data, defaultImage: UIImage? = nil, completion: @escaping ImageDownloadCompletion) {
        guard let image = UIImage(data: data) else {
            let customError = CustomError(area: "com.imagedownload.transform", description: "The image was not available", code: 500)
            completion(ImageResult.failure(error: customError, defaultImage: defaultImage))
            return
        }
        
        completion(ImageResult.successful(image: image))
    }
    
    /**
     Specifically handles networking failures from MBNetworking.
     - parameter url: The URL that has failed to download.
     - parameter error: An optional error from MBNetworking.
     - parameter completion: The completion into which we pass our user-pretty error.
     */
    private func handleFailure(url: URL, error: Error?, defaultImage: UIImage? = nil, completion: @escaping ImageDownloadCompletion) {
        guard let error = error else {
            let customError = CustomError(area: "com.imagedownload.noError", description: "The image was not available.", code: 500)
            completion(ImageResult.failure(error: customError, defaultImage: defaultImage))
            return
        }
        
        let nsError = error as NSError
        let customError = CustomError(area: nsError.domain, description: "The image was not available.", code: nsError.code)
        completion(ImageResult.failure(error: customError, defaultImage: defaultImage))
    }
    
    /**
     Looks for cached data for an image.
     - parameter url: The URL that has failed to download.
     - parameter error: An optional error from MBNetworking.
     - parameter completion: The completion into which we pass our user-pretty error.
     */
    private func fetchCachedImage(url: URL) -> UIImage? {
        guard case .success(data: let data, response: _) = cacher.get(url: url, type: self.cacheType) else {
            return nil
        }
        
        return UIImage(data: data)
    }
}
