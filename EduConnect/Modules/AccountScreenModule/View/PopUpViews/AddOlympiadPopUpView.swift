//
//  AddOlympiadPopUpView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//


import UIKit
import SnapKit
import UniformTypeIdentifiers

struct AddOlympiadPopUpViewModel: PopUpViewModel {
    var onClose: (() -> Void)?
    var didAddNewOlympiad: ((String, String, String?, [ECAttachedFile]) -> Void)?
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
    private var typeOfOlympiad: Int = 0
    
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
    
    private let addFilesAttachmentView: ECFileAttachmentView = {
        let view = ECFileAttachmentView()
        view.cellsWidth = 200.0
        view.maxFiles = 3
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
        return button
    }()
    
    private lazy var olympiadMenu: UIMenu = {
        let subjects = ENTSubject.allSubjects
        let actions = subjects.map { subject in
            let subjectTitle = subject.localizedName(lang: SharedConstants.currentLangugage)
            return UIAction(title: subjectTitle) { [weak self] _ in
                var title = AttributedString(subjectTitle)
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
    
    /// Olympiad Type
    
    private lazy var internationalButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.international, backgroundColor: .systemBackground, textColor: .blue)
        button.setAction { [weak self] in self?.chooseType(type: 1) }
        button.borderColor = .systemBlue
        button.borderWidth = 1
        return button
    }()
    
    private lazy var stateButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.state, backgroundColor: .systemBackground, textColor: .blue)
        button.setAction { [weak self] in self?.chooseType(type: 2) }
        button.borderColor = .systemBlue
        button.borderWidth = 1
        return button
    }()
    
    private lazy var cityButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.city, backgroundColor: .systemBackground, textColor: .blue)
        button.setAction { [weak self] in self?.chooseType(type: 3) }
        button.borderColor = .systemBlue
        button.borderWidth = 1
        return button
    }()
    
    private lazy var olympiadTypeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [internationalButton, stateButton, cityButton])
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
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chooseOlympiadButton.layer.borderColor = UIColor.black.cgColor
        chooseOlympiadButton.layer.cornerRadius = 10
        chooseOlympiadButton.layer.borderWidth = 1
    }
    
    // MARK: - PRIVATE FUNC
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
        
        contentView.addSubview(olympiadTypeStack)
        olympiadTypeStack.snp.makeConstraints {
            $0.top.equalTo(olympiadTypeLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints {
            $0.top.equalTo(olympiadTypeStack.snp.bottom).offset(Constants.spacing)
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
        
        addFilesAttachmentView.delegate = self
    }
    
    private func chooseType(type: Int) {
        switch type {
        case 1:
            internationalButton.reconfigure(backgroundColor: .systemBlue, textColor: .systemBackground)
            cityButton.reconfigure(backgroundColor: .systemBackground, textColor: .blue)
            stateButton.reconfigure(backgroundColor: .systemBackground, textColor: .blue)
        case 2:
            stateButton.reconfigure(backgroundColor: .systemBlue, textColor: .systemBackground)
            cityButton.reconfigure(backgroundColor: .systemBackground, textColor: .blue)
            internationalButton.reconfigure(backgroundColor: .systemBackground, textColor: .blue)
        case 3:
            cityButton.reconfigure(backgroundColor: .systemBlue, textColor: .systemBackground)
            internationalButton.reconfigure(backgroundColor: .systemBackground, textColor: .blue)
            stateButton.reconfigure(backgroundColor: .systemBackground, textColor: .blue)
        default:
            break
        }
    }
    
    @objc private func didTapCloseButton() {
        self.dismiss()
    }
}

extension AddOlympiadPopUpView: ECFileAttachmentViewDelegate {
    func fileAttachmentViewDidTapAdd(_ view: ECFileAttachmentView) {
        guard view.files.count < addFilesAttachmentView.maxFiles else { return }
        guard let viewController = findViewController() else { return }
        
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: view.allowedTypes)
        picker.delegate = self
        picker.allowsMultipleSelection = false
        
        viewController.present(picker, animated: true)
    }
    
    func fileAttachmentView(_ view: ECFileAttachmentView, didRemoveFile file: ECAttachedFile) { }
    
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

extension AddOlympiadPopUpView: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let availableSlots = addFilesAttachmentView.maxFiles - addFilesAttachmentView.files.count
        guard availableSlots > 0 else { return }
        
        for url in urls.prefix(availableSlots) {
            guard url.startAccessingSecurityScopedResource() else { continue }
            defer { url.stopAccessingSecurityScopedResource() }
            
            let resources = try? url.resourceValues(forKeys: [.fileSizeKey])
            let file = ECAttachedFile(
                name: url.lastPathComponent,
                size: Int64(resources?.fileSize ?? 0),
                url: url,
                type: UTType(filenameExtension: url.pathExtension)
            )
            
            addFilesAttachmentView.addFile(file)
        }
    }
}

