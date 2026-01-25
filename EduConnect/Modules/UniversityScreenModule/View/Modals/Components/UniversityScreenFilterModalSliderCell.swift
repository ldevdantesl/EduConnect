//
//  UniversityScreenFilterModelSliderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import UIKit
import SnapKit

struct UniversityScreenFilterModalSliderCellViewModel {
    let filterType: UniversityFilterOption
    var minValue: CGFloat = 100_000
    var maxValue: CGFloat = 10_000_000
    var currentMinValue: CGFloat = 100_000
    var currentMaxValue: CGFloat = 10_000_000
    var stepValue: CGFloat = 10_000
    var onValueChanged: ((CGFloat, CGFloat) -> Void)?
}

final class UniversityScreenFilterModalSliderCell: UICollectionViewCell {
    
    // MARK: - Constants
    fileprivate enum Constants {
        static let spacing = 15.0
        static let inputHeight = 50.0
        static let inputSpacing = 12.0
    }
    
    // MARK: - Properties
    private var viewModel: UniversityScreenFilterModalSliderCellViewModel?
    
    // MARK: - Views
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 18)
        label.text = "Цена"
        return label
    }()
    
    private let minInputContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let minInputLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let maxInputContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let maxInputLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let rangeSlider: ECRangeSlider = {
        let slider = ECRangeSlider()
        slider.minimumValue = 2_000_000
        return slider
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(withVM vm: UniversityScreenFilterModalSliderCellViewModel) {
        self.viewModel = vm
        
        titleLabel.text = vm.filterType.title
        
        rangeSlider.minimumValue = vm.minValue
        rangeSlider.maximumValue = vm.maxValue
        rangeSlider.stepValue = vm.stepValue
        rangeSlider.lowerValue = vm.currentMinValue
        rangeSlider.upperValue = vm.currentMaxValue
        
        updateLabels()
    }
    
    // MARK: - Private
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        contentView.addSubview(minInputContainer)
        minInputContainer.addSubview(minInputLabel)
        
        contentView.addSubview(maxInputContainer)
        maxInputContainer.addSubview(maxInputLabel)
        
        minInputContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.equalToSuperview()
            $0.height.equalTo(Constants.inputHeight)
        }
        
        maxInputContainer.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.equalTo(minInputContainer.snp.trailing).offset(Constants.inputSpacing)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(Constants.inputHeight)
            $0.width.equalTo(minInputContainer)
        }
        
        minInputLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.spacing)
        }
        
        maxInputLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(rangeSlider)
        rangeSlider.snp.makeConstraints {
            $0.top.equalTo(minInputContainer.snp.bottom).offset(Constants.spacing)
            $0.leading.trailing.equalToSuperview().inset(Constants.spacing)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() {
        rangeSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged() {
        updateLabels()
        viewModel?.onValueChanged?(rangeSlider.lowerValue, rangeSlider.upperValue)
    }
    
    private func updateLabels() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        
        minInputLabel.text = formatter.string(from: NSNumber(value: rangeSlider.lowerValue))
        maxInputLabel.text = formatter.string(from: NSNumber(value: rangeSlider.upperValue))
    }
}
