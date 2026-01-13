//
//  DiffableItem.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import Foundation

struct DiffableItem<VM>: Hashable {
    let id: UUID
    let viewModel: VM
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
