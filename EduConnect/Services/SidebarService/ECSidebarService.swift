//
//  SidebarService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import Foundation

final class ECSidebarService: SidebarServiceProtocol {
    weak var container: SidebarContainerViewController?
    
    // MARK: - CALLBACKS
    var onTabSelected: ((SidebarMenuTab) -> Void)?
    
    func toggle() { container?.toggleSidebar() }
    
    func open() { container?.openSidebar() }
    
    func close() { container?.closeSidebar() }
    
    func switchTo(tab: SidebarMenuTab) { close(); onTabSelected?(tab) }
}
