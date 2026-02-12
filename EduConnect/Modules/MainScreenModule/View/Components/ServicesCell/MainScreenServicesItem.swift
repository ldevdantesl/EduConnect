//
//  MainScreenServicesItem.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.02.2026.
//

import UIKit
import SnapKit

struct MainScreenServicesItemViewModel: CellViewModelProtocol {
    var cellIdentifier: String = MainScreenServicesItem.identifier
    let title: String
    let image: ImageConstants
    let onTapAction: (() -> Void)?
    
    init(title: String, image: ImageConstants, onTapAction: (() -> Void)? = nil) {
        self.title = title
        self.image = image
        self.onTapAction = onTapAction
    }
}

final class MainScreenServicesItem: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let imageSize = 40.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenServicesItemViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
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
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? MainScreenServicesItemViewModel else { return }
        self.viewModel = vm
        imageView.image = vm.image.image
        titleLabel.attributedText = NSAttributedString(
            string: vm.title,
            attributes: .init([
                .font: ECFont.font(.semiBold, size: 14),
                .foregroundColor: UIColor.black,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
        )
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview()
        }
        
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAction)))
    }
    
    // MARK: - OBJC
    @objc private func didTapAction() {
        self.animateTap(onCompletion: viewModel?.onTapAction)
    }
}
