//
//  SmallExerciseCell.swift
//  HandEase
//
//  Created by Matt Beaney on 06/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import UIKit

class SmallExerciseCell: UICollectionViewCell {
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: Bundle.main) }
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    typealias ExerciseTap = () -> Void
    typealias FavouriteTap = () -> Void
    
    var exerciseTap     : ExerciseTap?
    var favouriteTap    : FavouriteTap?
    
    func configure(viewModel: ExerciseViewModel) {
        self.thumbnail.image = nil
        viewModel.image { (image) in
            DispatchQueue.main.async {
                self.thumbnail.image = image
            }
        }
        
        self.lblTitle.text = viewModel.titleLabel
        self.configureFavourite(viewModel: viewModel, animated: false)
        
        let tappy = UITapGestureRecognizer(target: self, action: #selector(self.select(sender:)))
        self.addGestureRecognizer(tappy)
        self.btnFavourite.addTarget(self, action: #selector(favourite), for: .touchUpInside)
    }
    
    func configureFavourite(viewModel: ExerciseViewModel, animated: Bool) {
        FavouriteButtonCoordinator.configureFavourite(favouriteButton: self.btnFavourite,
                                                      favourited: viewModel.isFavourited,
                                                      animated: animated)
    }
    
    @objc func favourite() {
        self.favouriteTap?()
    }
    
    @objc func select(sender: UITapGestureRecognizer) {
        self.select(parent: self, sender: sender, duration: 0.2, tintColor: CustomColor.swooshSelectionColor.uiColor) {
            self.exerciseTap?()
        }
    }
}
