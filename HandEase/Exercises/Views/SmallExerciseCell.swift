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
    var exerciseTap: ExerciseTap?
    
    func configure(viewModel: DefaultExerciseViewModel) {
        viewModel.image { (image) in
            DispatchQueue.main.async {
                self.thumbnail.image = image
            }
        }
        
        self.lblTitle.text = viewModel.titleLabel
        
        let tappy = UITapGestureRecognizer(target: self, action: #selector(self.select(sender:)))
        self.addGestureRecognizer(tappy)
    }
    
    @objc func select(sender: UITapGestureRecognizer) {
        self.select(parent: self, sender: sender, duration: 0.2, tintColor: CustomColor.swooshSelectionColor.uiColor) {
            self.exerciseTap?()
        }
    }
}
