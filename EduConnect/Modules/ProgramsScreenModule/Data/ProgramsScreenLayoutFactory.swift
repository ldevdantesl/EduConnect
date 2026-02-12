//
//  ProgramsScreenLayoutFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.01.2026.
//

import UIKit

enum ProgramsScreenLayoutFactory {
    static func make() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: makeDefaultSection())
    }
    
    static func make(sectionStore: ECDiffableSectionStore<ProgramsScreenSection>) -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = sectionStore.section(at: sectionIndex) else { return makeDefaultSection() }
            switch section {
            case .programs: return makeProgramSection()
            default: return makeDefaultSection()
            }
        }
    }
    
    static func makeDefaultSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1000)
            )
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
    
    static func makeProgramSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(160)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(200)
            ),
            repeatingSubitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
}
