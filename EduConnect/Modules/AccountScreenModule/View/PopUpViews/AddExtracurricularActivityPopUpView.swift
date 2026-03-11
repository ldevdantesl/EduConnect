//
//  AddExtracurricularActivityPopUpView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.01.2026.
//

import UIKit
import SnapKit
import PhotosUI

struct AddExtracurricularActivityPopUpViewModel: PopUpViewModel {
    var activities: [ECExtracurricularActivity]
    var onClose: (() -> Void)?
    var didAddNewActivity: ((Int?, String?, [ECAttachedImage]) -> Void)?
    
    init(
        activities: [ECExtracurricularActivity] = [],
        onClose: (() -> Void)? = nil,
        didAddNewActivity: ((Int?, String?, [ECAttachedImage]) -> Void)? = nil
    ) {
        self.activities = activities
        self.onClose = onClose
        self.didAddNewActivity = didAddNewActivity
    }
}

final class AddExtracurricularActivityPopUpView: PopUpView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let xmarkImage = "xmark"
        static let xmarkButtonSize = 20.0
        static let smallSpacing = 5.0
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: AddExtracurricularActivityPopUpViewModel
    private var selectedActivity: ECExtracurricularActivity?
    
    // MARK: - VIEW PROPERTIES
    private let addActivityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.ExtraActivity.popupTitle
        label.font = ECFont.font(.bold, size: 16)
        return label
    }()
    
    private lazy var xmarkButton: ECIconButton = {
        let vm = ECIconButtonVM(systemImage: Constants.xmarkImage) { [weak self] in self?.didTapCloseButton() }
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let typeOfActivityLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Account.Expandable.ExtraActivity.typeOfActivity) *"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Common.description
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let descriptionTextView: ECExpandableTextView = {
        let text = ECExpandableTextView()
        text.placeholder = ConstantLocalizedStrings.Account.Expandable.ExtraActivity.describeActivity
        text.minHeight = 70
        return text
    }()
    
    private let filesLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Common.files
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let addFilesAttachmentView: ECImageAttachmentView = {
        let view = ECImageAttachmentView()
        view.maxImages = 3
        return view
    }()
    
    private let topDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.label.withAlphaComponent(0.8)
        return view
    }()
    
    private let bottomDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.label.withAlphaComponent(0.8)
        return view
    }()
    
    private lazy var cancelButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.cancel, backgroundColor: .white, textColor: .blue)
        button.borderColor = .blue
        button.borderWidth = 1
        button.setAction { [weak self] in self?.didTapCloseButton() }
        return button
    }()
    
    private lazy var addButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.add)
        button.setAction { [weak self] in
            let id = self?.selectedActivity?.id
            let text = self?.descriptionTextView.text
            let files = self?.addFilesAttachmentView.images
            self?.viewModel.didAddNewActivity?(id, text, files ?? [])
        }
        return button
    }()
    
    private lazy var activityMenu: UIMenu = {
        let actions = viewModel.activities.map { activity in
            UIAction(title: activity.name.toCurrentLanguage()) { [weak self] _ in
                self?.selectedActivity = activity
                var title = AttributedString(activity.name.toCurrentLanguage())
                title.font = ECFont.font(.semiBold, size: 14)
                title.foregroundColor = .label
                
                self?.chooseActivityButton.configuration?.attributedTitle = title
            }
        }
        
        return UIMenu(title: ConstantLocalizedStrings.Account.Expandable.ExtraActivity.typeOfActivity, children: actions)
    }()
    
    private lazy var chooseActivityButton: UIButton = {
        var title = AttributedString(ConstantLocalizedStrings.Account.Expandable.ExtraActivity.chooseActivity)
        title.font = ECFont.font(.semiBold, size: 14)
        title.foregroundColor = .label
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = title
        config.titleAlignment = .leading
        
        config.baseForegroundColor = .label
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        let button = UIButton(configuration: config)
        button.contentHorizontalAlignment = .leading
        button.showsMenuAsPrimaryAction = true
        button.menu = activityMenu
        return button
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: AddExtracurricularActivityPopUpViewModel, closesOnBackgroundTap: Bool = true, animationDuration: TimeInterval = 0.5) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel, closesOnBackgroundTap: closesOnBackgroundTap, animationDuration: animationDuration)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chooseActivityButton.layer.borderColor = UIColor.black.cgColor
        chooseActivityButton.layer.cornerRadius = 10
        chooseActivityButton.layer.borderWidth = 1
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(addActivityTitleLabel)
        addActivityTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        contentView.addSubview(xmarkButton)
        xmarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.xmarkButtonSize)
        }
        
        contentView.addSubview(topDividerView)
        topDividerView.snp.makeConstraints {
            $0.top.equalTo(addActivityTitleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(typeOfActivityLabel)
        typeOfActivityLabel.snp.makeConstraints {
            $0.top.equalTo(topDividerView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(chooseActivityButton)
        chooseActivityButton.snp.makeConstraints {
            $0.top.equalTo(typeOfActivityLabel.snp.bottom).offset(Constants.smallSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(chooseActivityButton.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(descriptionTextView)
        descriptionTextView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(filesLabel)
        filesLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(addFilesAttachmentView)
        addFilesAttachmentView.snp.makeConstraints {
            $0.top.equalTo(filesLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(bottomDividerView)
        bottomDividerView.snp.makeConstraints {
            $0.top.equalTo(addFilesAttachmentView.snp.bottom).offset(Constants.spacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(bottomDividerView.snp.bottom).offset(Constants.spacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }

        contentView.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.top.equalTo(bottomDividerView.snp.bottom).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
        
        addFilesAttachmentView.delegate = self
    }
    
    @objc private func didTapCloseButton() {
        self.dismiss()
    }
}

extension AddExtracurricularActivityPopUpView: ECImageAttachmentViewDelegate {
    func imageAttachmentViewDidTapAdd(_ view: ECImageAttachmentView) {
        guard let vc = findViewController() else { return }
        
        var config = PHPickerConfiguration()
        config.selectionLimit = view.maxImages - view.images.count
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        vc.present(picker, animated: true)
    }
    
    func imageAttachmentView(_ view: ECImageAttachmentView, didRemoveImage image: ECAttachedImage) { }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let vc = nextResponder as? UIViewController {
                return vc
            }
            responder = nextResponder
        }
        return nil
    }
}

extension AddExtracurricularActivityPopUpView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        for result in results {
            guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else { continue }

            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let image = object as? UIImage else { return }

                let name = (result.itemProvider.suggestedName ?? UUID().uuidString) + ".jpg"
                let attachedImage = ECAttachedImage(image: image, name: name)

                DispatchQueue.main.async {
                    self?.addFilesAttachmentView.addImage(attachedImage)
                }
            }
        }
    }
}
