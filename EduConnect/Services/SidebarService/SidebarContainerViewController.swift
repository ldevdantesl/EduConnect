//
//  SidebarContainerViewController.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import UIKit
import SnapKit

final class SidebarContainerViewController: UIViewController {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let sidebarWidthRatio: CGFloat = 0.6
        static let animationDuration: TimeInterval = 0.25
        static let dimmingAlpha: CGFloat = 0.5
    }
    
    // MARK: - PROPERTIES
    private let sidebarService: ECSidebarService
    private let rootViewController: UIViewController
    private var isSidebarOpen = false
    private var isSidebarEnabled = true
    private var sidebarLeadingConstraint: Constraint?
    
    // MARK: - VIEW PROPERTIES
    private let mainContainerView = UIView()
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeSidebar))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var sidebarMenuView: SidebarMenuView = {
        let vm = SidebarMenuViewModel(selectedItem: .none) { [weak self] in self?.sidebarService.switchTo(tab: $0) }
        let menu = SidebarMenuView(viewModel: vm)
        return menu
    }()
    
    // MARK: - LIFECYCLE
    init(rootViewController: UIViewController, sidebarService: ECSidebarService) {
        self.rootViewController = rootViewController
        self.sidebarService = sidebarService
        super.init(nibName: nil, bundle: nil)
        
        sidebarService.container = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        addChild(rootViewController)
        mainContainerView.addSubview(rootViewController.view)
        rootViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        rootViewController.didMove(toParent: self)
        
        view.addSubview(mainContainerView)
        mainContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(dimmingView)
        dimmingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
                
        view.addSubview(sidebarMenuView)
        sidebarMenuView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(Constants.sidebarWidthRatio)
            sidebarLeadingConstraint = $0.trailing.equalTo(view.snp.leading).constraint
        }
    }
    
    // MARK: - PUBLIC FUNC
    public func toggleSidebar() {
        guard isSidebarEnabled else { return }
        isSidebarOpen ? closeSidebar() : openSidebar()
    }
    
    public func openSidebar() {
        guard isSidebarEnabled, !isSidebarOpen else { return }
        isSidebarOpen = true
        
        let sidebarWidth = view.bounds.width * Constants.sidebarWidthRatio
        sidebarLeadingConstraint?.update(offset: sidebarWidth)
        
        dimmingView.isHidden = false
        
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.dimmingView.alpha = Constants.dimmingAlpha
            self.view.layoutIfNeeded()
        }
    }
    
    public func setSidebarEnabled(_ enabled: Bool) {
        isSidebarEnabled = enabled
        if !enabled && isSidebarOpen {
            closeSidebar()
        }
    }
    
    // MARK: - OBJC FUNC
    @objc public func closeSidebar() {
        guard isSidebarOpen else { return }
        isSidebarOpen = false
        
        sidebarLeadingConstraint?.update(offset: 0)
        
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.dimmingView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.dimmingView.isHidden = true
        }
    }
}
