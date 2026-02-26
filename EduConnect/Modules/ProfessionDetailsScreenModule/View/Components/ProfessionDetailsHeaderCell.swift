//
//  ProfessionDetailsHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 25.02.2026.
//

import UIKit
import SnapKit

struct ProfessionDetailsHeaderCellViewModel: CellViewModelProtocol {
    let cellIdentifier: String = ProfessionDetailsHeaderCell.identifier
    let profession: ECProfession
    let didTapSetENT: (() -> Void)?
    
    init(profession: ECProfession, didTapSetENT: (() -> Void)? = nil) {
        self.profession = profession
        self.didTapSetENT = didTapSetENT
    }
}

final class ProfessionDetailsHeaderCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProfessionDetailsHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageConstants.professionDetailsHeaderImage.image
        image.contentMode = .scaleToFill
        return image
    }()
    
    private let imageOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = ECFont.font(.bold, size: 22)
        label.textAlignment = .left
        return label
    }()
    
    private let universityView: ECTwoLabelVStack = {
        let view = ECTwoLabelVStack()
        view.firstLineLabel.textColor = .white
        view.firstLineLabel.font = ECFont.font(.semiBold, size: 18)
        view.firstLineLabel.numberOfLines = 1
        
        view.secondLineLabel.textColor = .white
        view.secondLineLabel.font = ECFont.font(.semiBold, size: 14)
        view.secondLineLabel.text = "вуза"
        view.secondLineLabel.numberOfLines = 2
        
        view.vStack.alignment = .leading
        return view
    }()
    
    private let programView: ECTwoLabelVStack = {
        let view = ECTwoLabelVStack()
        view.firstLineLabel.textColor = .white
        view.firstLineLabel.font = ECFont.font(.semiBold, size: 18)
        view.firstLineLabel.numberOfLines = 1
        
        view.secondLineLabel.textColor = .white
        view.secondLineLabel.font = ECFont.font(.semiBold, size: 14)
        view.secondLineLabel.text = "программ обучения"
        view.secondLineLabel.numberOfLines = 2
        
        view.vStack.alignment = .leading
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.required, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.required, for: .horizontal)
        let stack = UIStackView(arrangedSubviews: [universityView, spacer, programView])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private let setENTButton: ECButton = ECButton(
        text: "Укажите ЕНТ", textSize: 14,
        backgroundColor: .white, textColor: .systemBlue,
        cornerRadius: 10
    )
    
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
    func configure(withVM vm: ProfessionDetailsHeaderCellViewModel) {
        self.viewModel = vm
        titleLabel.text = "Профессия \(vm.profession.name.ru)"
        universityView.firstLineLabel.text = vm.profession.universitiesCount.description
        programView.firstLineLabel.text = vm.profession.programsCount.description
        setENTButton.setAction(action: vm.didTapSetENT)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        headerImageView.addSubview(imageOverlayView)
        imageOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageOverlayView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        imageOverlayView.addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        imageOverlayView.addSubview(setENTButton)
        setENTButton.snp.makeConstraints {
            $0.top.equalTo(hStack.snp.bottom).offset(Constants.spacing)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
