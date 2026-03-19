//
//  MainScreenStepsCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 16.02.2026.
//

import UIKit
import SnapKit

struct MainScreenStepsCellViewModel {
    var didTapChooseProfession: (() -> Void)?
    var didTapChooseENT: (() -> Void)?
    var didTapChooseUniversity: (() -> Void)?
    var didTapShowAllItems: (() -> Void)?
    var showingAllItems: Bool
    
    init(
        showingAllItems: Bool = false,
        didTapChooseProfession: (() -> Void)? = nil, didTapChooseENT: (() -> Void)? = nil,
        didTapChooseUniversity: (() -> Void)? = nil, didTapShowAllItems: (() -> Void)? = nil
    ) {
        self.showingAllItems = showingAllItems
        self.didTapChooseProfession = didTapChooseProfession
        self.didTapChooseENT = didTapChooseENT
        self.didTapChooseUniversity = didTapChooseUniversity
        self.didTapShowAllItems = didTapShowAllItems
    }
}

final class MainScreenStepsCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 20.0
        static let vSpacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenStepsCellViewModel?
    private var showAllTopConstraint: Constraint?
    
    // MARK: - VIEW PROPERTIES
    private lazy var chooseProfessionButton: ECDashedBorderView = makeStepButton(
        number: "1",
        title: ConstantLocalizedStrings.Main.Steps.chooseProfession,
        image: ImageConstants.mainChooseProfessionImage.image,
        backgroundColor: .blue,
        numberTextColor: .white.withAlphaComponent(0.8),
        numberBackgroundColor: UIColor.white.withAlphaComponent(0.3),
        titleTextColor: .white,
        buttonBackgroundColor: .white,
        buttonForegroundColor: .black,
        onTap: { [weak self] in self?.viewModel?.didTapChooseProfession?() }
    )


    private lazy var chooseENTButton: ECDashedBorderView = makeStepButton(
        number: "2",
        title: ConstantLocalizedStrings.Main.Steps.chooseEnt,
        image: ImageConstants.mainChooseENTImage.image,
        backgroundColor: .white,
        numberTextColor: .purple.withAlphaComponent(0.8),
        numberBackgroundColor: .purple.withAlphaComponent(0.1),
        titleTextColor: .black,
        buttonBackgroundColor: .purple,
        buttonForegroundColor: .white,
        onTap: { [weak self] in self?.viewModel?.didTapChooseENT?() }
    )
    
    private lazy var chooseUniversityButton: ECDashedBorderView = makeStepButton(
        number: "3",
        title: ConstantLocalizedStrings.Main.Steps.chooseUni,
        image: ImageConstants.mainChooseUniversityImage.image,
        backgroundColor: .systemBlue,
        numberTextColor: .white.withAlphaComponent(0.8),
        numberBackgroundColor: UIColor.white.withAlphaComponent(0.3),
        titleTextColor: .white,
        buttonBackgroundColor: .white,
        buttonForegroundColor: .black,
        onTap: { [weak self] in self?.viewModel?.didTapChooseUniversity?() }
    )
    
    private let topButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private let showAllUnderlineButton: ECUnderlineButton = ECUnderlineButton()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: MainScreenStepsCellViewModel) {
        self.viewModel = vm

        let showingAll = vm.showingAllItems
        chooseUniversityButton.isHidden = !showingAll
        showAllTopConstraint?.deactivate()

        showAllUnderlineButton.snp.makeConstraints {
            showAllTopConstraint =
            $0.top.equalTo(showingAll ? chooseUniversityButton.snp.bottom : topButtonStack.snp.bottom).offset(Constants.spacing).constraint
        }

        showAllUnderlineButton.configure(
            text: showingAll ? ConstantLocalizedStrings.Main.Steps.hideSteps : ConstantLocalizedStrings.Main.Steps.showAllSteps,
            textSize: 14, textColor: .blue
        )
        showAllUnderlineButton.setAction(action: vm.didTapShowAllItems)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        
        [chooseProfessionButton, chooseENTButton].forEach { topButtonStack.addArrangedSubview($0) }
        contentView.addSubview(topButtonStack)
        topButtonStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.vSpacing)
            $0.height.lessThanOrEqualTo(300)
        }
        
        contentView.addSubview(chooseUniversityButton)
        chooseUniversityButton.snp.makeConstraints {
            $0.top.equalTo(topButtonStack.snp.bottom).offset(Constants.vSpacing)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(topButtonStack.snp.width).multipliedBy(0.5)
        }
        
        contentView.addSubview(showAllUnderlineButton)
        showAllUnderlineButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
        }
    }
    
    private func makeStepButton(
        number: String,
        title: String,
        image: UIImage?,
        backgroundColor: UIColor,
        numberTextColor: UIColor,
        numberBackgroundColor: UIColor,
        titleTextColor: UIColor,
        buttonBackgroundColor: UIColor,
        buttonForegroundColor: UIColor,
        onTap: (() -> Void)?
    ) -> ECDashedBorderView {
        let container = ECDashedBorderView()
        container.cornerRadius = 50
        container.showShadow = true
        container.contentView.backgroundColor = backgroundColor

        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = ECFont.font(.semiBold, size: 16)
        numberLabel.textColor = numberTextColor
        numberLabel.backgroundColor = numberBackgroundColor
        numberLabel.textAlignment = .center
        numberLabel.layer.cornerRadius = 15
        numberLabel.clipsToBounds = true

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = ECFont.font(.bold, size: 18)
        titleLabel.textColor = titleTextColor
        titleLabel.numberOfLines = 2

        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        let startButton = ECButton(
            text: "Начать", textSize: 16,
            backgroundColor: buttonBackgroundColor, textColor: buttonForegroundColor,
            cornerRadius: 20
        )
        startButton.setAction(action: onTap)

        container.contentView.addSubview(numberLabel)
        container.contentView.addSubview(titleLabel)
        container.contentView.addSubview(imageView)
        container.contentView.addSubview(startButton)

        numberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.vSpacing)
            $0.leading.equalToSuperview().offset(Constants.vSpacing)
            $0.size.equalTo(30)
        }

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.vSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.vSpacing)
            $0.width.equalTo(67)
            $0.height.equalTo(51)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(Constants.vSpacing)
        }

        startButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.vSpacing)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
        }

        container.setAction(action: onTap)
        return container
    }
}
