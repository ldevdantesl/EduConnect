//
//  UniversityScreenFilterModelSliderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import UIKit
import SnapKit

struct UniversityScreenFilterModalPriceCellViewModel {
    let title: String
    var currentMinValue: Int?
    var currentMaxValue: Int?
    var onValueChanged: ((Int?, Int?) -> Void)?
}

final class UniversityScreenFilterModalPriceCell: UICollectionViewCell {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 15.0
        static let inputHeight = 50.0
        static let inputSpacing = 12.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityScreenFilterModalPriceCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 18)
        return label
    }()
    
    private lazy var minTextField: ECTextField = {
        let tf = ECTextField()
        tf.placeholder = ConstantLocalizedStrings.Words.from
        tf.keyboardType = .numberPad
        tf.cornerRadius = 12
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()
    
    private lazy var maxTextField: ECTextField = {
        let tf = ECTextField()
        tf.placeholder = ConstantLocalizedStrings.Words.to
        tf.keyboardType = .numberPad
        tf.cornerRadius = 12
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
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
        minTextField.text = nil
        maxTextField.text = nil
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: UniversityScreenFilterModalPriceCellViewModel) {
        self.viewModel = vm
        titleLabel.text = vm.title
        minTextField.text = vm.currentMinValue.map { formatNumber($0) }
        maxTextField.text = vm.currentMaxValue.map { formatNumber($0) }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        contentView.addSubview(minTextField)
        contentView.addSubview(maxTextField)
        
        minTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.equalToSuperview()
            $0.height.equalTo(Constants.inputHeight)
            $0.bottom.equalToSuperview()
        }
        
        maxTextField.snp.makeConstraints {
            $0.top.equalTo(minTextField)
            $0.leading.equalTo(minTextField.snp.trailing).offset(Constants.inputSpacing)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(Constants.inputHeight)
            $0.width.equalTo(minTextField)
        }
    }
    
    private func formatNumber(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    private func parseNumber(_ text: String?) -> Int? {
        guard let text, !text.isEmpty else { return nil }
        let cleaned = text.replacingOccurrences(of: " ", with: "")
        return Int(cleaned)
    }
    
    // MARK: - OBJC FUNC
    @objc private func textFieldDidChange() {
        let minVal = parseNumber(minTextField.text)
        let maxVal = parseNumber(maxTextField.text)
        viewModel?.onValueChanged?(minVal, maxVal)
    }
}
