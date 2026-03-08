//
//  MainScreenHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

struct MainScreenHeaderCellViewModel { }

final class MainScreenHeaderCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 20.0
        static let vSpacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let text = "Траектория поступления\nв вузы Казахстана"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [
                .font: ECFont.font(.bold, size: 24),
                .foregroundColor: UIColor.black
            ]
        )

        if let range = text.range(of: "в вузы Казахстана") {
            let nsRange = NSRange(range, in: text)
            attributed.addAttributes(
                [.font: ECFont.font(.regular, size: 18)],
                range: nsRange
            )
        }
        
        let label = UILabel()
        label.attributedText = attributed
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var statsStack: UIStackView = {
        let programsStack = makeStack(titleText: "6731", subtitleText: "программ")
        let unisStack = makeStack(titleText: "1143", subtitleText: "вузов")
        let budgetStack = makeStack(titleText: "441343", subtitleText: "бюджетных мест")
        let stack = UIStackView(arrangedSubviews: [programsStack, unisStack, budgetStack])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.alignment = .top
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
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: MainScreenHeaderCellViewModel) {
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(statsStack)
        statsStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
    
    private func makeStack(titleText: String, subtitleText: String) -> UIStackView {
        let label = UILabel()
        label.text = titleText
        label.font = ECFont.font(.semiBold, size: 18)
        label.textColor = .black
        label.numberOfLines = 1
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitleText
        subtitleLabel.font = ECFont.font(.semiBold, size: 14)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.numberOfLines = 2
        
        let stack = UIStackView(arrangedSubviews: [label, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 0
        
        return stack
    }
}
