//
//  SidebarService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import Foundation

protocol SidebarServiceProtocol: AnyObject {
    var isSidebarEnabled: Bool { get }
    func toggle()
    func open()
    func close()
    func switchTo(tab: SidebarMenuTab)
    func setSidebarEnabled(_ enabled: Bool)
}


final class ECSidebarService: SidebarServiceProtocol {
    
    // MARK: - PROPERTIES
    weak var container: SidebarContainerViewController?
    private(set) var isSidebarEnabled: Bool = true
    
    // MARK: - CALLBACKS
    var onTabSelected: ((SidebarMenuTab) -> Void)?
    
    func toggle() { container?.toggleSidebar() }
    
    func open() { container?.openSidebar() }
    
    func close() { container?.closeSidebar() }
    
    func switchTo(tab: SidebarMenuTab) { close(); onTabSelected?(tab) }
    
    func setSidebarEnabled(_ enabled: Bool) {
        isSidebarEnabled = enabled
        container?.setSidebarEnabled(enabled)
    }
}
