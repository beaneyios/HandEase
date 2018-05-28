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
    
    //MARK: ---- Configuration ----
    func configure(viewModel: ExerciseViewModel) {
        self.thumbnail.image = nil
        self.configureTitle(titleLabel: viewModel.titleLabel)
        self.configureFavourite(viewModel: viewModel, animated: false)
        self.configureTap()
        
        viewModel.image { (image) in
            self.configureImage(image: image)
        }
    }
    
    func configureFavourite(viewModel: ExerciseViewModel, animated: Bool) {
        FavouriteButtonCoordinator.configureFavourite(favouriteButton: self.btnFavourite,
                                                      favourited: viewModel.isFavourited,
                                                      animated: animated)
    }
    
    private func configureTitle(titleLabel: String) {
        self.lblTitle.text = titleLabel
    }
    
    private func configureTap() {
        let tappy = UITapGestureRecognizer(target: self, action: #selector(self.select(sender:)))
        self.addGestureRecognizer(tappy)
        self.btnFavourite.addTarget(self, action: #selector(favourite), for: .touchUpInside)
    }
    
    private func configureImage(image: UIImage?) {
        DispatchQueue.main.async {
            self.thumbnail.alpha = 0.0
            self.thumbnail.image = image
            UIView.animate(withDuration: 0.2, animations: {
                self.thumbnail.alpha = 1.0
            })
        }
    }
    
    //MARK: ---- Actions ----
    @objc func favourite() {
        self.favouriteTap?()
    }
    
    @objc func select(sender: UITapGestureRecognizer) {
        self.select(parent: self, sender: sender, duration: 0.2, tintColor: CustomColor.swooshSelectionColor.uiColor) {
            self.exerciseTap?()
        }
    }
}
