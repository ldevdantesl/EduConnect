//
//  UniversityScreenLayoutFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

enum UniversityScreenLayoutFactory {
    static func make() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(section: makeDefaultSection())
    }
    
    static func make(sectionStore: ECDiffableSectionStore<UniversityScreenSection>) -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = sectionStore.section(at: sectionIndex) else { return makeDefaultSection() }
            switch section {
            case .universities: return makeUniversitySection()
            default: return makeDefaultSection()
            }
        }
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
    
    static func makeUniversitySection() -> NSCollectionLayoutSection {
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
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
}
