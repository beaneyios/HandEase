//
//  DefaultMenuViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class DefaultMenuViewModel: NSObject, MenuViewModel {
    fileprivate var sizer       : MenuItemSizer
    fileprivate var dataSource  : MenuItemDataSource
    fileprivate var theme       : MenuTheme
    
    var action: MenuItemActionClosure?
    
    var backgroundColor: UIColor {
        return self.theme.backColor.uiColor
    }
    
    init(sizer: MenuItemSizer, dataSource: MenuItemDataSource, theme: MenuTheme) {
        self.sizer      = sizer
        self.dataSource = dataSource
        self.theme      = theme
    }
    
    func bind(withAction action: @escaping MenuItemActionClosure) {
        self.action = action
    }
    
    func bind(cview: UICollectionView) {
        cview.register          (MenuItemCollectionViewCell.nib, forCellWithReuseIdentifier: "standard_cell")
        cview.delegate          = self
        cview.dataSource        = self
        cview.backgroundColor   = self.theme.backColor.uiColor
        cview.reloadData()
    }
}

extension DefaultMenuViewModel : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "standard_cell", for: indexPath)
        guard let castCell  = cell as? MenuItemCollectionViewCell else { return MenuItemCollectionViewCell() }
        
        let item            = self.dataSource.items[indexPath.row]
        castCell.configure  (with: DefaultMenuItemViewModel(menuItem: item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.items.count
    }
}

extension DefaultMenuViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item                = self.dataSource.items[indexPath.row]
        return self.sizer.size  (for: item, container: collectionView)
    }
}

extension DefaultMenuViewModel : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? MenuItemCollectionViewCell,
            let action = cell.vm?.action
        else
        {
            return
        }
        
        self.action?(action)
    }
}
