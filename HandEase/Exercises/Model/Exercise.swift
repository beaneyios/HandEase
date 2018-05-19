//
//  Exercise.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

struct Exercise: Codable, Equatable {
    var title    : String
    var imageURL : String
    var body     : String
    var videoURL : String
    
    init(title: String, imageURL: String, body: String, videoURL: String) {
        self.title      = title
        self.imageURL   = imageURL
        self.body       = body
        self.videoURL   = videoURL
    }
    
    /**
     Our feed is delivered via JSON, we need to be able to map this to an object.
     - parameter data: The data returned representing the JSON feed.
     */
    static func parseJSON(data: Data) -> [Exercise]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([Exercise].self, from: data)
    }
    
    /**
     We might want a JSON representation of this object, luckily, Codable to the rescue!
     - parameter data: The data returned representing the JSON feed.
     */
    static func data(exercises: [Exercise]) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(exercises)
    }
}
