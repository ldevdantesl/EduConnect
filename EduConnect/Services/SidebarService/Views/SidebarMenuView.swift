//
//  SidebarMenuView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import UIKit
import SnapKit

struct SidebarMenuViewModel {
    let selectedItem: SidebarMenuTab
    let onItemTapped: ((SidebarMenuTab) -> Void)?
    
    init(selectedItem: SidebarMenuTab = .universities, onItemTapped: ((SidebarMenuTab) -> Void)? = nil) {
        self.selectedItem = selectedItem
        self.onItemTapped = onItemTapped
    }
}

final class SidebarMenuView: UIView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let imageSize = 40.0
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: SidebarMenuViewModel
    
    // MARK: - VIEW PROPERTIES
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageConstants.appLogo)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let tabsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = Constants.spacing
        return stack
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: SidebarMenuViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        makeTabs()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Constants.spacing)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
        }
        
        addSubview(tabsStackView)
        tabsStackView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Constants.spacing * 2)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func makeTabs() {
        SidebarMenuTab.allCases.enumerated().forEach { index, item in
            guard item != .none else { return }
            let label = UILabel()
            label.text = item.title
            label.textAlignment = .center
            label.font = ECFont.font(.regular, size: 18)
            label.isUserInteractionEnabled = true
            label.tag = index

            let tap = UITapGestureRecognizer(target: self, action: #selector(selectedTab(_:)))
            label.addGestureRecognizer(tap)

            tabsStackView.addArrangedSubview(label)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func selectedTab(_ gesture: UITapGestureRecognizer) {
        guard
            let label = gesture.view as? UILabel,
            let item = SidebarMenuTab.allCases[safe: label.tag]
        else { return }

        viewModel.onItemTapped?(item)
    }
}
