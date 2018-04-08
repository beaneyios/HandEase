//
//  MenuItemCollectionViewCell.swift
//  HandEase
//
//  Created by Matt Beaney on 07/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: Bundle.main) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with vm: MenuItemViewModel) {
        self.imgIcon.image = vm.imgIcon
        self.imgIcon.tintColor = vm.foreColor
        self.lblTitle.text = vm.strTitle
    }
}
