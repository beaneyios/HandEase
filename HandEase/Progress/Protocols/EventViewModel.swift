//
//  EventViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 28/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation

protocol EventViewModel {
    var titleLabel: String { get }
    var lastCompleted: String { get }
    var eventCount: String { get }
    func image(completion: @escaping ImageCompletion)
}
