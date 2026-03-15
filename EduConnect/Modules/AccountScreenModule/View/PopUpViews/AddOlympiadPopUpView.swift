//
//  AddOlympiadPopUpView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//


import UIKit
import SnapKit
import PhotosUI

struct AddOlympiadPopUpViewModel: PopUpViewModel {
    var olympiadTypes: [ECOlympiadType]
    var olympiadPlaces: [ECOlympiadPlace]
    var onClose: (() -> Void)?
    var didAddNewOlympiad: ((Int?, Int?, String?, [ECAttachedImage]) -> Void)?
    
    init(
        olympiadTypes: [ECOlympiadType],
        olympiadPlaces: [ECOlympiadPlace],
        onClose: (() -> Void)? = nil,
        didAddNewOlympiad: ((Int?, Int?, String?, [ECAttachedImage]) -> Void)? = nil
    ) {
        self.olympiadPlaces = olympiadPlaces
        self.olympiadTypes = olympiadTypes
        self.onClose = onClose
        self.didAddNewOlympiad = didAddNewOlympiad
    }
}

final class AddOlympiadPopUpView: PopUpView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let xmarkImage = "xmark"
        static let xmarkButtonSize = 20.0
        static let smallSpacing = 5.0
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: AddOlympiadPopUpViewModel
    private var selectedType: ECOlympiadType?
    private var selectedPlace: ECOlympiadPlace?
    
    // MARK: - VIEW PROPERTIES
    private let addOlympiadTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.Olympiad.popupTitle
        label.font = ECFont.font(.bold, size: 16)
        return label
    }()
    
    private lazy var xmarkButton: ECIconButton = {
        let vm = ECIconButtonVM(systemImage: Constants.xmarkImage) { [weak self] in self?.didTapCloseButton() }
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let olympiadLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Account.Expandable.Olympiad.olympiad) *"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let olympiadTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Common.type)*"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.Olympiad.yearOfSubmission
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let yearField: ECTextField = {
        let field = ECTextField(placeHolder: "2020")
        field.keyboardType = .numberPad
        return field
    }()
    
    private let filesLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Common.files
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private lazy var addFilesAttachmentView: ECImageAttachmentView = {
        let view = ECImageAttachmentView()
        view.maxImages = 3
        view.delegate = self
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
            let typeID = self?.selectedType?.id
            let placeID = self?.selectedPlace?.id
            let year = self?.yearField.text
            let files = self?.addFilesAttachmentView.images
            self?.viewModel.didAddNewOlympiad?(typeID, placeID, year, files ?? [])
        }
        return button
    }()
    
    private lazy var olympiadMenu: UIMenu = {
        let actions = viewModel.olympiadTypes.map { type in
            UIAction(title: type.name.toCurrentLanguage()) { [weak self] _ in
                self?.selectedType = type
                
                var title = AttributedString(type.name.toCurrentLanguage())
                title.font = ECFont.font(.semiBold, size: 14)
                title.foregroundColor = .label
                self?.chooseOlympiadButton.configuration?.attributedTitle = title
            }
        }
        return UIMenu(title: ConstantLocalizedStrings.Account.Expandable.Olympiad.olympiad, children: actions)
    }()
    
    private lazy var chooseOlympiadButton: UIButton = {
        var title = AttributedString(ConstantLocalizedStrings.Account.Expandable.Olympiad.chooseOlympiad)
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
        button.menu = olympiadMenu
        return button
    }()
    
    // MARK: - Place buttons (dynamic)
    private var placeButtons: [ECButton] = []
    
    private lazy var placesScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.showsHorizontalScrollIndicator = false
        scroll.alwaysBounceHorizontal = true
        return scroll
    }()
    
    private lazy var placesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.isUserInteractionEnabled = true
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: AddOlympiadPopUpViewModel, closesOnBackgroundTap: Bool = true, animationDuration: TimeInterval = 0.5) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel, closesOnBackgroundTap: closesOnBackgroundTap, animationDuration: animationDuration)
        buildPlaceButtons()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chooseOlympiadButton.layer.borderColor = UIColor.black.cgColor
        chooseOlympiadButton.layer.cornerRadius = 10
        chooseOlympiadButton.layer.borderWidth = 1
    }
    
    // MARK: - PRIVATE FUNC
    private func buildPlaceButtons() {
        placeButtons = viewModel.olympiadPlaces.map { place in
            let button = ECButton(
                text: place.name.toCurrentLanguage(),
                backgroundColor: .systemBackground,
                textColor: .blue
            )
            button.borderColor = .systemBlue
            button.borderWidth = 1
            button.setAction { [weak self] in
                self?.selectPlace(place)
            }
            return button
        }
        
        placeButtons.forEach { placesStack.addArrangedSubview($0) }
    }
    
    private func selectPlace(_ place: ECOlympiadPlace) {
        selectedPlace = place
        
        for (index, button) in placeButtons.enumerated() {
            let isSelected = viewModel.olympiadPlaces[index].id == place.id
            UIView.animate(withDuration: 0.25) {
                button.reconfigure(
                    backgroundColor: isSelected ? .systemBlue : .systemBackground,
                    textColor: isSelected ? .systemBackground : .blue
                )
            }
        }
    }
    
    private func setupUI() {
        contentView.addSubview(addOlympiadTitleLabel)
        addOlympiadTitleLabel.snp.makeConstraints {
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
            $0.top.equalTo(addOlympiadTitleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(olympiadLabel)
        olympiadLabel.snp.makeConstraints {
            $0.top.equalTo(topDividerView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(chooseOlympiadButton)
        chooseOlympiadButton.snp.makeConstraints {
            $0.top.equalTo(olympiadLabel.snp.bottom).offset(Constants.smallSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(olympiadTypeLabel)
        olympiadTypeLabel.snp.makeConstraints {
            $0.top.equalTo(chooseOlympiadButton.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(placesScrollView)
        placesScrollView.snp.makeConstraints {
            $0.top.equalTo(olympiadTypeLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
        }

        placesScrollView.addSubview(placesStack)
        placesStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.height.equalTo(placesScrollView.snp.height)
        }
        
        contentView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints {
            $0.top.equalTo(placesScrollView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(yearField)
        yearField.snp.makeConstraints {
            $0.top.equalTo(yearLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(filesLabel)
        filesLabel.snp.makeConstraints {
            $0.top.equalTo(yearField.snp.bottom).offset(Constants.spacing)
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
    }
    
    @objc private func didTapCloseButton() {
        self.dismiss()
    }
}

extension AddOlympiadPopUpView: ECImageAttachmentViewDelegate {
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

extension AddOlympiadPopUpView: PHPickerViewControllerDelegate {
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
