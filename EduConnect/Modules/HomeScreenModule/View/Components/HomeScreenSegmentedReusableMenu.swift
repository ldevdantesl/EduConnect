//
//  HomeScreenSegmentedMenu.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import UIKit
import SnapKit


final class HomeScreenSegmentedReusableMenu: UICollectionReusableView {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 30.0
        static let cornerRadius = 15.0
    }
    
    // MARK: - STATIC
    static let reuseID = "HomeScreenSegmentedReusableMenu"
    
    // MARK: - PROPERTIES
    static let selectedTab: Int = 1
    
    // MARK: - VIEW PROPERTIES
    private let mainButton: ECButton = {
        let button = ECButton(text: "Main", cornerRadius: Constants.cornerRadius)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let myUniversitiesButton: ECButton = {
        let button = ECButton(text: "My Unis", cornerRadius: Constants.cornerRadius)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let applicationButton: ECButton = {
        let button = ECButton(text: "Application", cornerRadius: Constants.cornerRadius)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainButton,myUniversitiesButton,applicationButton])
        stack.axis = .horizontal
        stack.spacing = Constants.spacing
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.backgroundColor = .systemBlue
        addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.spacing)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
