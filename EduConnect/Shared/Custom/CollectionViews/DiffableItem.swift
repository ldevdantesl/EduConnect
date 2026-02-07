//
//  DiffableItem.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import Foundation

struct DiffableItem<VM>: Hashable {
    let id: AnyHashable
    let version: Int
    let viewModel: VM
    
    init(id: AnyHashable, viewModel: VM, version: Int = 0) {
        self.id = id
        self.viewModel = viewModel
        self.version = version
    }
    
    init(viewModel: VM, version: Int = 0) {
        self.id = UUID()
        self.viewModel = viewModel
        self.version = version
    }
    
    init<T: Identifiable>(item: T, prefix: String, viewModel: VM, version: Int = 0) {
        self.id = "\(prefix)-\(item.id)"
        self.viewModel = viewModel
        self.version = version
    }
    
    init<T: Identifiable>(item: T, viewModel: VM, version: Int = 0) {
        self.id = "\(String(describing: T.self))-\(item.id)"
        self.viewModel = viewModel
        self.version = version
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(version)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.version == rhs.version
    }
}
