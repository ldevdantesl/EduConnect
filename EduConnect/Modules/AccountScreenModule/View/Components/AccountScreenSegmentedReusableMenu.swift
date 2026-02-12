//
//  HomeScreenSegmentedMenu.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import UIKit
import SnapKit

struct AccountScreenSegmentedReusableMenuViewModel {
    let currentTab: AccountScreenTab
    let didSelectTab: ((AccountScreenTab) -> Void)?
}

final class AccountScreenSegmentedReusableMenu: UICollectionReusableView {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let smallSpacing = 5.0
        static let spacing = 10.0
        static let biggerSpacing = 20.0
        static let hSpacing = 30.0
        static let cornerRadius = 15.0
    }
    
    // MARK: - STATIC
    static let reuseID = "AccountScreenSegmentedReusableMenu"
    
    // MARK: - PROPERTIES
    private var viewModel: AccountScreenSegmentedReusableMenuViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let mainButton: ECButton = ECButton(text: "Main", textSize: 15, cornerRadius: Constants.cornerRadius)
    
    private let myUniversitiesButton: ECButton = ECButton(text: "My Unis", textSize: 15, cornerRadius: Constants.cornerRadius)
    
    private let applicationButton: ECButton = ECButton(text: "Application", textSize: 15, cornerRadius: Constants.cornerRadius)
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainButton, myUniversitiesButton, applicationButton])
        stack.axis = .horizontal
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil

        resetButtons()
    }
    
    // MARK: - PUBLIC FUNC
    public func configure(withVM vm: AccountScreenSegmentedReusableMenuViewModel) {
        viewModel = vm

        resetButtons()

        switch vm.currentTab {
        case .myUniversities: myUniversitiesButton.reconfigure(backgroundColor: .white, textColor: .black)
        case .application: applicationButton.reconfigure(backgroundColor: .white, textColor: .black)
        case .main: mainButton.reconfigure(backgroundColor: .white, textColor: .black)
        }

        myUniversitiesButton.setAction { vm.didSelectTab?(.myUniversities) }
        applicationButton.setAction { vm.didSelectTab?(.application) }
        mainButton.setAction { vm.didSelectTab?(.main) }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.backgroundColor = .systemBlue
        addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.smallSpacing)
        }
    }
    
    private func resetButtons() {
        [mainButton, myUniversitiesButton, applicationButton].forEach {
            $0.reconfigure(
                backgroundColor: .clear,
                textColor: .white
            )
            $0.setAction(action: nil)
        }
    }
}
