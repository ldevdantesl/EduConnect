//
//  LoginScreenDataSource.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.01.2026.
//

import UIKit

final class LoginScreenDataSource: NSObject, UICollectionViewDataSource {
    
    let items: [CellViewModel]
    
    init(items: [CellViewModel]) {
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier, for: indexPath)
        
        if let cell = cell as? ConfigurableCell {
            cell.configure(withVM: item)
        }
        
        return cell
    }
}
