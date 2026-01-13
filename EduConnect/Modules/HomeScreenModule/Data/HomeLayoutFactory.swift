//
//  HomeLayoutFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

enum HomeLayoutFactory {

    static func make() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(500)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        item.edgeSpacing = .init(leading: nil, top: .fixed(10), trailing: nil, bottom: .fixed(10))
    
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(500)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(70)
        )

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        header.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil,
            top: nil,
            trailing: nil,
            bottom: .fixed(12)
        )
        
        section.boundarySupplementaryItems = [header]

        return UICollectionViewCompositionalLayout(section: section)
    }
}
