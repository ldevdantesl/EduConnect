//
//  SidebarServiceProtocol.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import Foundation

protocol SidebarServiceProtocol: AnyObject {
    func toggle()
    func open()
    func close()
    func switchTo(tab: SidebarMenuTab)
}
