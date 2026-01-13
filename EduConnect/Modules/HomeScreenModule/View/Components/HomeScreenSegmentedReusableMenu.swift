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
    }
    
    // MARK: - STATIC
    static let reuseID = "HomeScreenSegmentedReusableMenu"
    
    // MARK: - VIEW PROPERTIES
    private let mainButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setTitle("Main", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let myUniversitiesButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setTitle("My Unis", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let applicationButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setTitle("Application", for: .normal)
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
