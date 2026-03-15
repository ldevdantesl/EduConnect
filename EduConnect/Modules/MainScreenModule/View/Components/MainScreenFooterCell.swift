//
//  MainScreenFooterCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import UIKit
import SnapKit

struct MainScreenFooterCellViewModel {
    let programsCount: Int
    let universitiesCount: Int
    let budgetPlacesCount: Int
}

final class MainScreenFooterCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    private enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
        static let hugeSpacing = 30.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenFooterCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Высшее образование\nв Казахстане"
        label.font = ECFont.font(.bold, size: 28)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let statsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .top
        stack.spacing = 10
        return stack
    }()
    
    private let percentageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Образование в Казахстане"
        label.font = ECFont.font(.semiBold, size: 16)
        label.textColor = .systemGray
        return label
    }()
    
    private let percentageSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Доступное качественное образование для всех"
        label.font = ECFont.font(.regular, size: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Казахстан — страна потрясающих возможностей для получения высшего образования. По состоянию
        на 2025 год в Казахстане насчитывается более 130 вузов. Это 40 государственных учебных заведений, из которых 15 — университеты, 10 — академии, и 5 — институтов. Также есть около 90 частных образовательных организаций. В казахстанских вузах обучается порядка 500 тысяч студентов. В 2025 году в университетах Казахстана предусмотрено более 70 тыс. бюджетных мест для приема. Сайт предоставляет абитуриенту 2025 возможность сравнить и выбрать вузы, программы образования, пройти профориентацию и оценить свои шансы поступить. Полный справочник абитуриента для поступающих в вузы Казахстана.
        """
        label.font = ECFont.font(.regular, size: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
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
        statsStack.arrangedSubviews.forEach { $0.removeFromSuperview(); statsStack.removeArrangedSubview($0) }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: MainScreenFooterCellViewModel) {
        self.viewModel = vm
        let programsStatView = makeStatView(number: vm.programsCount, subtitle: "программы")
        let privateUnisStatView = makeStatView(number: vm.universitiesCount, subtitle: "частных вузов")
        let budgetPlacesCount = makeStatView(number: vm.budgetPlacesCount, subtitle: "бюджетных мест")
        statsStack.addArrangedSubview(programsStatView)
        statsStack.addArrangedSubview(privateUnisStatView)
        statsStack.addArrangedSubview(budgetPlacesCount)
    }
    
    // MARK: - PRIVATE FUNC
    private func makeStatView(number: Int, subtitle: String) -> UIView {
        let container = UIView()

        let numberLabel = UILabel()
        numberLabel.text = "\(number)"
        numberLabel.font = ECFont.font(.bold, size: 18)
        numberLabel.textColor = .label

        let titleLabel = UILabel()
        titleLabel.text = subtitle
        titleLabel.font = ECFont.font(.regular, size: 14)
        titleLabel.textColor = .secondaryLabel
        titleLabel.numberOfLines = 0

        container.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        return container
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hugeSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(statsStack)
        statsStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(percentageTitleLabel)
        percentageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(statsStack.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(percentageSubtitleLabel)
        percentageSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(percentageTitleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(percentageSubtitleLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
