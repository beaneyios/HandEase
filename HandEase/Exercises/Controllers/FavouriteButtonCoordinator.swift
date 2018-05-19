//
//  FavouriteButtonCoordinator.swift
//  HandEase
//
//  Created by Matt Beaney on 19/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

struct FavouriteButtonCoordinator {
    static func configureFavourite(favouriteButton: UIButton, favourited: Bool, animated: Bool) {
        let imageApply = {
            let imageType = favourited ? ImageType.exerciseHeartIconSaved : ImageType.exerciseHeartIcon
            favouriteButton.setImage(UIImage(type: imageType), for: .normal)
        }
        
        if !animated {
            imageApply()
            return
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            favouriteButton.alpha = 0.0
        }) { (finished) in
            imageApply()
            UIView.animate(withDuration: 0.2, animations: {
                favouriteButton.alpha = 1.0
            })
        }
    }
}
