//
//  MainScreenHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

struct MainScreenHeaderCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = MainScreenHeaderCell.identifier
    var didTapChooseProfession: (() -> Void)?
    var didTapChooseENT: (() -> Void)?
    
    init(didTapChooseProfession: (() -> Void)? = nil, didTapChooseENT: (() -> Void)? = nil) {
        self.didTapChooseProfession = didTapChooseProfession
        self.didTapChooseENT = didTapChooseENT
    }
}

final class MainScreenHeaderCell: UICollectionViewCell, ConfigurableCellProtocol {
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
    
    private let chooseProfessionButton: ECDashedBorderView = {
        let view = ECDashedBorderView()
        view.cornerRadius = 50
        view.showShadow = true
        view.contentView.backgroundColor = .blue
        return view
    }()

    private let chooseENTButton: ECDashedBorderView = {
        let view = ECDashedBorderView()
        view.cornerRadius = 50
        view.showShadow = true
        view.contentView.backgroundColor = .white
        return view
    }()
    
    private lazy var buttonsStack: UIStackView = {
        setupButton1()
        setupButton2()
        let stack = UIStackView(arrangedSubviews: [chooseProfessionButton, chooseENTButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private let showAllUnderlineButton: ECUnderlineButton = {
        let button = ECUnderlineButton()
        button.configure(text: "Развернуть все шаги", textSize: 14, textColor: .blue)
        return button
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
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? MainScreenHeaderCellViewModel else { return }
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
        }
        
        contentView.addSubview(buttonsStack)
        buttonsStack.snp.makeConstraints {
            $0.top.equalTo(statsStack.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.vSpacing)
            $0.height.lessThanOrEqualTo(300)
        }
        
        contentView.addSubview(showAllUnderlineButton)
        showAllUnderlineButton.snp.makeConstraints {
            $0.top.equalTo(buttonsStack.snp.bottom).offset(Constants.vSpacing + Constants.spacing)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
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
    
    private func setupButton1() {
        let numberLabel1 = UILabel()
        numberLabel1.text = "1"
        numberLabel1.font = ECFont.font(.semiBold, size: 16)
        numberLabel1.textColor = .white.withAlphaComponent(0.8)
        numberLabel1.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        numberLabel1.textAlignment = .center
        numberLabel1.layer.cornerRadius = 15
        numberLabel1.clipsToBounds = true
        
        let titleLabel1 = UILabel()
        titleLabel1.text = "Выбери\nпрофессию"
        titleLabel1.font = ECFont.font(.bold, size: 18)
        titleLabel1.textColor = .white
        titleLabel1.numberOfLines = 2
        
        let imageView1 = UIImageView()
        imageView1.image = ImageConstants.mainChooseProfessionImage.image
        imageView1.contentMode = .scaleAspectFill
        imageView1.clipsToBounds = true
        
        let startButton1 = UIButton(type: .system)

        var config = UIButton.Configuration.filled()
        config.title = "Начать"
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .fixed
        config.background.cornerRadius = 20
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )

        config.attributedTitle = AttributedString(
            "Начать",
            attributes: AttributeContainer([
                .font: ECFont.font(.semiBold, size: 16)
            ])
        )

        startButton1.configuration = config
        
        chooseProfessionButton.contentView.addSubview(numberLabel1)
        chooseProfessionButton.contentView.addSubview(titleLabel1)
        chooseProfessionButton.contentView.addSubview(imageView1)
        chooseProfessionButton.contentView.addSubview(startButton1)
        
        numberLabel1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.vSpacing)
            $0.leading.equalToSuperview().offset(Constants.vSpacing)
            $0.size.equalTo(30)
        }
        
        imageView1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.vSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.vSpacing)
            $0.width.equalTo(67)
            $0.height.equalTo(51)
        }
        
        titleLabel1.snp.makeConstraints {
            $0.top.equalTo(numberLabel1.snp.bottom)
            $0.leading.equalToSuperview().offset(Constants.vSpacing)
        }
        
        startButton1.snp.makeConstraints {
            $0.top.equalTo(titleLabel1.snp.bottom).offset(Constants.vSpacing)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
        }
        
        chooseProfessionButton.onTap = { [weak self] in
            self?.viewModel?.didTapChooseProfession?()
        }
    }
    
    private func setupButton2() {
        let numberLabel2 = UILabel()
        numberLabel2.text = "2"
        numberLabel2.font = ECFont.font(.semiBold, size: 16)
        numberLabel2.textColor = .purple.withAlphaComponent(0.8)
        numberLabel2.backgroundColor = .purple.withAlphaComponent(0.1)
        numberLabel2.textAlignment = .center
        numberLabel2.layer.cornerRadius = 15
        numberLabel2.clipsToBounds = true
        
        let titleLabel2 = UILabel()
        titleLabel2.text = "Выбери\nЕНТ"
        titleLabel2.font = ECFont.font(.bold, size: 18)
        titleLabel2.textColor = .black
        titleLabel2.numberOfLines = 2
        
        let imageView2 = UIImageView()
        imageView2.image = ImageConstants.mainChooseENTImage.image
        imageView2.contentMode = .scaleAspectFill
        imageView2.clipsToBounds = true
        
        let startButton2 = UIButton(type: .system)

        var config = UIButton.Configuration.filled()
        config.title = "Начать"
        config.baseBackgroundColor = .purple
        config.baseForegroundColor = .white
        config.cornerStyle = .fixed
        config.background.cornerRadius = 20
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )

        config.attributedTitle = AttributedString(
            "Начать",
            attributes: AttributeContainer([
                .font: ECFont.font(.semiBold, size: 16)
            ])
        )

        startButton2.configuration = config
        chooseENTButton.contentView.addSubview(numberLabel2)
        chooseENTButton.contentView.addSubview(titleLabel2)
        chooseENTButton.contentView.addSubview(imageView2)
        chooseENTButton.contentView.addSubview(startButton2)
        
        numberLabel2.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constants.vSpacing)
            $0.size.equalTo(30)
        }
        
        imageView2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.vSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.vSpacing)
            $0.width.equalTo(67)
            $0.height.equalTo(51)
        }
        
        titleLabel2.snp.makeConstraints {
            $0.top.equalTo(numberLabel2.snp.bottom).offset(Constants.vSpacing)
            $0.leading.equalToSuperview().offset(Constants.vSpacing)
        }
        
        startButton2.snp.makeConstraints {
            $0.top.equalTo(titleLabel2.snp.bottom).offset(Constants.vSpacing)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().offset(-Constants.vSpacing)
        }
        
        chooseENTButton.onTap = { [weak self] in
            self?.viewModel?.didTapChooseENT?()
        }
    }
}
