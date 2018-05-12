//
//  DefaultMenuViewModel.swift
//  HandEase
//
//  Created by Matt Beaney on 08/04/2018.
//  Copyright © 2018 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class MenuViewModel: NSObject, MenuViewModellable {
    typealias Dependencies = HasMenuItemSizer & HasMenuTheme & HasMenuItemDataSource
    private var dependencies: Dependencies
    
    struct Config: Dependencies {
        var dataSource: MenuItemDataSource
        var sizer: MenuItemSizer
        var theme: MenuTheme
    }
    
    var action: MenuItemActionClosure?
    
    var backgroundColor: UIColor {
        return self.dependencies.theme.backColor.uiColor
    }
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func bind(withAction action: @escaping MenuItemActionClosure) {
        self.action = action
    }
    
    func bind(cview: UICollectionView) {
        cview.register          (MenuItemCollectionViewCell.nib, forCellWithReuseIdentifier: "standard_cell")
        cview.delegate          = self
        cview.dataSource        = self
        cview.backgroundColor   = self.dependencies.theme.backColor.uiColor
        cview.reloadData()
    }
}

extension MenuViewModel : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: "standard_cell", for: indexPath)
        guard let castCell  = cell as? MenuItemCollectionViewCell else { return MenuItemCollectionViewCell() }
        
        let item            = self.dependencies.dataSource.items[indexPath.row]
        castCell.configure  (with: MenuItemViewModel(menuItem: item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dependencies.dataSource.items.count
    }
}

extension MenuViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item                = self.dependencies.dataSource.items[indexPath.row]
        return self.dependencies.sizer.size  (for: item, container: collectionView)
    }
}

extension MenuViewModel : UICollectionViewDelegate {
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
