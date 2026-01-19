//
//  HomeScreenExpandableOlympiadcell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 19.01.2026.
//

import UIKit
import SnapKit

final class HomeScreenExpandableOlympiadCellViewModel: ExpandableCellViewModel {
    private(set) var cellIdentifier: String = "HomeScreenExpandableOlympiadCell"
    var isExpanded: Bool
    let didTapExpand: (() -> Void)?
    
    init(isExpanded: Bool, didTapExpand: (() -> Void)? = nil) {
        self.isExpanded = isExpanded
        self.didTapExpand = didTapExpand
    }
}

final class HomeScreenExpandableOlympiadCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        
        static let plusImageName = "plus"
        static let expandImageSize = 20.0
        static let chevronDownImage = "chevron.down"
        static let chevronUpImage = "chevron.up"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: HomeScreenExpandableOlympiadCellViewModel?
    private var expandableHeightConstraint: Constraint?
    private var isEditing: Bool = false
    
    // MARK: - VIEW PROPERTIES
    private var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private var expandableContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        return view
    }()
    
    private let expandImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemBlue
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Olympiads"
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.label
        return label
    }()
    
    private lazy var addOlympiadButton: UIView = makeAddOlympiadButton()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        contentView.layer.cornerRadius = 10
        
        headerContainer.layer.borderWidth = 1
        headerContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        headerContainer.layer.cornerRadius = 10
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collapseCell()
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? HomeScreenExpandableOlympiadCellViewModel else { return }
        self.viewModel = vm
        vm.isExpanded ? expandCell() : collapseCell()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapExpand))
        self.headerContainer.addGestureRecognizer(tap)
        contentView.addSubview(headerContainer)
        headerContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        headerContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.spacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        headerContainer.addSubview(expandImageView)
        expandImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.expandImageSize)
        }
        
        contentView.addSubview(expandableContainer)
        expandableContainer.snp.makeConstraints {
            $0.top.equalTo(headerContainer.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview()
            expandableHeightConstraint = $0.height.equalTo(0).priority(.required).constraint
        }
        
        expandableContainer.addSubview(addOlympiadButton)
        addOlympiadButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing).priority(.high)
        }
    }
    
    private func expandCell() {
        expandableHeightConstraint?.deactivate()
        expandImageView.image = UIImage(systemName: Constants.chevronUpImage)
        layoutIfNeeded()
    }
    
    private func collapseCell() {
        expandableHeightConstraint?.activate()
        expandImageView.image = UIImage(systemName: Constants.chevronDownImage)
        layoutIfNeeded()
    }
    
    private func makeAddOlympiadButton() -> UIView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.plusImageName)
        imageView.tintColor = .systemBlue
        
        let addSubjectTextLabel = UILabel()
        addSubjectTextLabel.text = "Add Olympiad"
        addSubjectTextLabel.textColor = .systemBlue
        addSubjectTextLabel.font = ECFont.font(.regular, size: 14)
        
        
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(Constants.expandImageSize)
        }
        
        view.addSubview(addSubjectTextLabel)
        addSubjectTextLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(Constants.spacing)
            $0.centerY.equalTo(imageView)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
        
        return view
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapExpand() {
        viewModel?.didTapExpand?()
    }
}

