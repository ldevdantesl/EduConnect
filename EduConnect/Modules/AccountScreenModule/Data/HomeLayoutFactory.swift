//
//  HomeLayoutFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

enum HomeLayoutFactory {

    static func make() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1000))
        )
        
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        item.edgeSpacing = .init(leading: nil, top: .fixed(10), trailing:.fixed(10), bottom: .fixed(10))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: item.layoutSize.widthDimension,
                heightDimension: item.layoutSize.heightDimension
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(110)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = .init(top: 0, leading: 0, bottom: 30, trailing: 0)
        
        section.boundarySupplementaryItems = [header]

        return UICollectionViewCompositionalLayout(section: section)
    }
}
