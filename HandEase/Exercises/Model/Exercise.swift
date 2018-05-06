//
//  Exercise.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

struct Exercise: Codable {
    var title    : String
    var imageURL   : String
    var body     : String
    
    init(title: String, imageURL: String, body: String) {
        self.title      = title
        self.imageURL   = imageURL
        self.body       = body
    }
}
