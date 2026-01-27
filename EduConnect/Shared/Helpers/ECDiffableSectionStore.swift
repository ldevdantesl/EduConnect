//
//  ECSectionStore.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 27.01.2026.
//

import UIKit

final class ECDiffableSectionStore<Section: Hashable>: @unchecked Sendable {
    private var sections: [Section] = []
    
    func update(_ newSections: [Section]) {
        sections = newSections
    }
    
    func section(at index: Int) -> Section? {
        guard index >= 0 && index < sections.count else { return nil }
        return sections[index]
    }
}
