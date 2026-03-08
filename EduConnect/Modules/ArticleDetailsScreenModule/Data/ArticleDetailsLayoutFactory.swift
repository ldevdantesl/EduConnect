//
//  ArticleDetailsLayoutFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.03.2026.
//

import UIKit

enum ArticlesDetailsLayoutFactory {
    static func make() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1000))
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: item.layoutSize.widthDimension,
                heightDimension: item.layoutSize.heightDimension
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
