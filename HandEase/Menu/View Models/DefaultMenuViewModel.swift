//
//  DefaultMenuViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class DefaultMenuViewModel : NSObject, MenuViewModel {
    fileprivate var sizer       : MenuItemSizer
    fileprivate var dataSource  : MenuItemDataSource
    
    init(sizer: MenuItemSizer, dataSource: MenuItemDataSource) {
        self.sizer      = sizer
        self.dataSource = dataSource
    }
    
    func bind(cview: UICollectionView) {
        cview.register(MenuItemCollectionViewCell.nib, forCellWithReuseIdentifier: "standard_cell")
        cview.delegate      = self
        cview.dataSource    = self
        cview.reloadData()
    }
}

extension DefaultMenuViewModel : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "standard_cell", for: indexPath)
        guard let castCell = cell as? MenuItemCollectionViewCell else { return MenuItemCollectionViewCell() }
        
        let item = self.dataSource.items[indexPath.row]
        castCell.configure(with: DefaultMenuItemViewModel(menuItem: item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.items.count
    }
}

extension DefaultMenuViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.dataSource.items[indexPath.row]
        return self.sizer.size(for: item, container: collectionView)
    }
}

extension DefaultMenuViewModel : UICollectionViewDelegate {
    
}
