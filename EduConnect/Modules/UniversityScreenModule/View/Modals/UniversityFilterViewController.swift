//
//  FilterScreenModalViewController.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import UIKit
import SnapKit

final class UniversityScreenFilterModalControllerViewModel {
    let filterOptions: [UniversityFilterOption] = UniversityFilterOption.allCases
    var selectedFilters: UniversityFilters
    
    var cities: [ECCity] = []
    var professions: [ECProfession] = []
    
    var onApplyFilters: ((UniversityFilters) -> Void)?
    var onFiltersChanged: (() -> Void)?
    
    init(currentFilters: UniversityFilters, cities: [ECCity] = [], professions: [ECProfession] = []) {
        self.selectedFilters = currentFilters
        self.cities = cities
        self.professions = professions
    }
    
    func subItems(for option: UniversityFilterOption) -> [String] {
        if let staticItems = option.staticSubItems {
            return staticItems
        }
        
        switch option {
        case .city: return [option.noneTitle] + cities.map { $0.name.ru }
        case .profession: return [option.noneTitle] + professions.map { $0.name.ru }
        default: return []
        }
    }
    
    func selectedValue(for option: UniversityFilterOption) -> String? {
        option.selectedValue(from: selectedFilters, cities: cities, professions: professions)
    }
    
    func applyValue(_ value: String, for option: UniversityFilterOption) {
        option.applyValue(value, to: &selectedFilters, cities: cities, professions: professions)
        onFiltersChanged?()
    }
    
    func selectPriceRange(min: Int, max: Int) {
        selectedFilters.priceMin = min
        selectedFilters.priceMax = max
    }
    
    func applyFilters() {
        onApplyFilters?(selectedFilters)
    }
}

final class UniversityScreenFilterModalController: UIViewController {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let containerCornerRadius = 20.0
        static let spacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: UniversityScreenFilterModalControllerViewModel
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Фильтр по вузам"
        label.font = ECFont.font(.bold, size: 22)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UniversityScreenFilterModalOptionCell.self, forCellWithReuseIdentifier: UniversityScreenFilterModalOptionCell.identifier)
        cv.register(UniversityScreenFilterModalSliderCell.self, forCellWithReuseIdentifier: UniversityScreenFilterModalSliderCell.identifier)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let applyButton: ECButton = {
        let button = ECButton(text: "Применить")
        return button
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: UniversityScreenFilterModalControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.onFiltersChanged = { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
        }
        
        applyButton.setAction { [weak self] in
            self?.viewModel.applyFilters()
            self?.dismiss(animated: true)
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.view.layer.cornerRadius = Constants.containerCornerRadius
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        view.addSubview(collectionView)
        view.addSubview(applyButton)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.leading.trailing.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalTo(applyButton.snp.top).offset(-Constants.spacing)
        }
        
        applyButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.spacing)
            $0.height.equalTo(SharedConstants.buttonHeight)
        }
    }
}

extension UniversityScreenFilterModalController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let option = viewModel.filterOptions[indexPath.item]
        
        if option.isSlider {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversityScreenFilterModalSliderCell.identifier, for: indexPath) as! UniversityScreenFilterModalSliderCell
            let cellVM = UniversityScreenFilterModalSliderCellViewModel(
                filterType: option,
                currentMinValue: CGFloat(viewModel.selectedFilters.priceMin ?? 0),
                currentMaxValue: CGFloat(viewModel.selectedFilters.priceMax ?? 5_000_000),
                onValueChanged: { [weak self] min, max in self?.viewModel.selectPriceRange(min: Int(min), max: Int(max)) }
            )
            cell.configure(withVM: cellVM)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UniversityScreenFilterModalOptionCell.identifier, for: indexPath) as! UniversityScreenFilterModalOptionCell
        let cellVM = UniversityScreenFilterModalOptionCellViewModel(
            filterType: option,
            selectedValue: viewModel.selectedValue(for: option),
            subItems: viewModel.subItems(for: option),
            onSelectOption: { [weak self] value in
                self?.viewModel.applyValue(value, for: option)
            }
        )
        cell.configure(withVM: cellVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let option = viewModel.filterOptions[indexPath.item]
        let height: CGFloat = option.isSlider ? 160 : 50
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}
