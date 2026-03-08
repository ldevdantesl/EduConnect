//
//  ShowENTPopupView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.03.2026.
//

import UIKit
import SnapKit

struct ShowENTPopupViewModel: PopUpViewModel {
    let subjects: [ENTSubject]
    var onConfirm: (() -> Void)? = nil
    var onClose: (() -> Void)?
}

final class ShowENTPopupView: PopUpView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let buttonHeight: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 20
        static let selectedColor: UIColor = .purple
        static let spacing: CGFloat = 15
    }

    // MARK: - PROPERTIES
    private let viewModel: ShowENTPopupViewModel
    private var selections: [Int: Int] = [:]

    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажи ЕНТ"
        label.font = ECFont.font(.bold, size: 18)
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажи результаты ЕНТ используя диапазоны"
        label.font = ECFont.font(.medium, size: 12)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: Constants.spacing, bottom: 0, right: Constants.spacing)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(ShowENTPopupCell.self, forCellWithReuseIdentifier: ShowENTPopupCell.identifier)
        return cv
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = Constants.selectedColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(self, action: #selector(didTapOK), for: .touchUpInside)
        return button
    }()

    // MARK: - LIFECYCLE
    init(viewModel: ShowENTPopupViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }

        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }

        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(SharedConstants.screenHeight * 0.5)
        }

        contentView.addSubview(okButton)
        okButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
            $0.height.equalTo(Constants.buttonHeight)
        }
    }

    // MARK: - OBJC FUNC
    @objc private func didTapOK() {
        viewModel.onConfirm?()
        dismiss()
    }
}

extension ShowENTPopupView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.subjects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShowENTPopupCell.identifier,
            for: indexPath
        ) as? ShowENTPopupCell else {
            return UICollectionViewCell()
        }

        let subject = viewModel.subjects[indexPath.item]
        let vm = ShowENTPopupCellViewModel(subject: subject, selectedRangeIndex: self.selections[indexPath.item]) { [weak self] in
            self?.selections[indexPath.item] = $0
        }
        cell.configure(withVM: vm)
        return cell
    }
}

extension ShowENTPopupView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - Constants.spacing * 2
        return CGSize(width: width, height: 120)
    }
}
