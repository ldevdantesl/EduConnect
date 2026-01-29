//
//  DiffableItem.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import Foundation

struct DiffableItem<VM>: Hashable {
    let id: AnyHashable
    let viewModel: VM
    
    init(id: AnyHashable, viewModel: VM) {
        self.id = id
        self.viewModel = viewModel
    }
    
    init(viewModel: VM) {
        self.id = UUID()
        self.viewModel = viewModel
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
