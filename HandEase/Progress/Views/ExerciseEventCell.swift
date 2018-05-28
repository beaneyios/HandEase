//
//  ExerciseEventCell.swift
//  HandEase
//
//  Created by Matt Beaney on 20/05/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import UIKit

class ExerciseEventCell: UICollectionViewCell {
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: Bundle.main) }

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLastCompleted: UILabel!
    @IBOutlet weak var lblExerciseCount: UILabel!
    
    typealias ExerciseTap = () -> Void
    var exerciseTap     : ExerciseTap?
    
    func configure(viewModel: ExerciseEventViewModel) {
        self.thumbnail.image        = nil
        self.lblTitle.text          = viewModel.titleLabel
        self.lblLastCompleted.text  = viewModel.lastCompleted
        self.lblExerciseCount.text  = viewModel.eventCount
        
        viewModel.image { (image) in
            self.configureImage(image: image)
        }
        
        self.configureTap()
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
    
    private func configureTap() {
        let tappy = UITapGestureRecognizer(target: self, action: #selector(self.select(sender:)))
        self.addGestureRecognizer(tappy)
    }
    
    @objc func select(sender: UITapGestureRecognizer) {
        self.select(parent: self, sender: sender, duration: 0.2, tintColor: CustomColor.swooshSelectionColor.uiColor) {
            self.exerciseTap?()
        }
    }
}
