//
//  UnderlineButtonCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import UIKit
import SnapKit

struct UnderlineButtonCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = UnderlineButtonCell.identifier
    let titleName: String
    let titleSize: CGFloat
    let titleColor: UIColor
    let onTapAction: (() -> Void)?
    
    init(titleName: String, titleSize: CGFloat = 16, titleColor: UIColor = .black, onTapAction: (() -> Void)? = nil) {
        self.titleName = titleName
        self.titleSize = titleSize
        self.titleColor = titleColor
        self.onTapAction = onTapAction
    }
}

final class UnderlineButtonCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UnderlineButtonCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let underlineButton = ECUnderlineButton()
    
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
        guard let vm = vm as? UnderlineButtonCellViewModel else { return }
        self.viewModel = vm
        underlineButton.configure(text: vm.titleName, textSize: vm.titleSize, textColor: vm.titleColor)
        underlineButton.setAction(action: vm.onTapAction)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(underlineButton)
        underlineButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
