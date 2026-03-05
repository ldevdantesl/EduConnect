//
//  ShowENTPopupCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import UIKit
import SnapKit

struct ShowENTPopupCellViewModel {
    let subject: ENTSubject
    var selectedRangeIndex: Int?
    var onRangeSelected: ((Int) -> Void)? = nil
}

final class ShowENTPopupCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    static let ranges: [(title: String, maxValue: Int)] = [
        ("от 10 до 30", 30),
        ("от 31 до 40", 40),
        ("от 41 до 60", 60),
        ("от 61 до 100", 100)
    ]
    private enum Constants {
        static let buttonHeight: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 20
        static let gridSpacing: CGFloat = 8
        static let selectedColor: UIColor = UIColor(red: 101/255, green: 80/255, blue: 220/255, alpha: 1)
        static let unselectedColor: UIColor = .systemGray5
    }

    // MARK: - PROPERTIES
    private var viewModel: ShowENTPopupCellViewModel?
    private var rangeButtons: [UIButton] = []
    private var selectedRangeIndex: Int?

    // MARK: - VIEW PROPERTIES
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 20)
        label.textAlignment = .center
        return label
    }()

    private let gridStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = Constants.gridSpacing
        return sv
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
    }

    // MARK: - PUBLIC FUNC
    func configure(withVM vm: ShowENTPopupCellViewModel) {
        self.viewModel = vm
        self.nameLabel.text = vm.subject.name.ru
        self.selectedRangeIndex = vm.selectedRangeIndex
        updateAllButtonStates()
    }

    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }

        contentView.addSubview(gridStack)
        gridStack.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.gridSpacing)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        buildGrid()
    }

    private func buildGrid() {
        for rowStart in stride(from: 0, to: Self.ranges.count, by: 2) {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = Constants.gridSpacing
            rowStack.distribution = .fillEqually

            for col in 0..<2 {
                let index = rowStart + col
                guard index < Self.ranges.count else { break }

                let button = UIButton(type: .system)
                button.setTitle(Self.ranges[index].title, for: .normal)
                button.setTitleColor(.label, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 14)
                button.backgroundColor = Constants.unselectedColor
                button.layer.cornerRadius = Constants.buttonCornerRadius
                button.tag = index
                button.addTarget(self, action: #selector(didTapRange(_:)), for: .touchUpInside)

                rangeButtons.append(button)
                rowStack.addArrangedSubview(button)
            }

            rowStack.snp.makeConstraints {
                $0.height.equalTo(Constants.buttonHeight)
            }

            gridStack.addArrangedSubview(rowStack)
        }
    }

    private func updateAllButtonStates() {
        for button in rangeButtons {
            let isSelected = button.tag == selectedRangeIndex
            button.backgroundColor = isSelected ? Constants.selectedColor : Constants.unselectedColor
            button.setTitleColor(isSelected ? .white : .label, for: .normal)
        }
    }

    // MARK: - OBJC FUNC
    @objc private func didTapRange(_ sender: UIButton) {
        selectedRangeIndex = sender.tag
        updateAllButtonStates()
        viewModel?.onRangeSelected?(sender.tag)
    }
}
