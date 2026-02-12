//
//  UniversityInfoScreenLayoutFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 30.01.2026.
//

import UIKit

enum UniversityInfoScreenLayoutFactory {
    
    static func make(sectionStore: ECDiffableSectionStore<UniversityInfoScreenSection>) -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = sectionStore.section(at: sectionIndex) else { return makeDefaultSection() }
            switch section {
            default: return makeDefaultSection()
            }
        }
    }
    
    static func make() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: makeDefaultSection())
    }
    
    static func makeDefaultSection() -> NSCollectionLayoutSection {
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
        return section
    }
}
