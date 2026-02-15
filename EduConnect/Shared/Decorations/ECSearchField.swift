import UIKit

final class ECSearchField: UITextField, UITextFieldDelegate {
    
    private let rightViewWidth: CGFloat = 44
    private(set) var tapAction: ((String) -> Void)?
    private var searchImageView: UIImageView?

    // MARK: - LIFECYCLE
    init(placeholder: String) {
        super.init(frame: .zero)
        configure(placeholder: placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC FUNC
    public func setAction(action: @escaping (String) -> Void) {
        self.tapAction = action
    }
    
    // MARK: - PRIVATE FUNC
    private func configure(placeholder: String) {
        borderStyle = .none
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor

        font = ECFont.font(.medium, size: 14)
        textColor = .label

        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.systemGray,
                .font: ECFont.font(.medium, size: 14)
            ]
        )

        returnKeyType = .search
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        self.delegate = self

        setupSearchIcon()
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    private func setupSearchIcon() {
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass", withConfiguration: config))
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 36))
        container.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 6, y: 8, width: 20, height: 20)
        container.addSubview(imageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchIconTapped))
        container.addGestureRecognizer(tapGesture)

        rightView = container
        rightViewMode = .always
        
        self.searchImageView = imageView
    }

    // MARK: - ACTIONS
    @objc private func searchIconTapped() {
        searchImageView?.animateTap()
        resignFirstResponder()
        guard let text = text, !text.isEmpty else { return }
        tapAction?(text)
    }
    
    @objc private func textDidChange() {
        let hasText = (text?.count ?? 0) > 1
        searchImageView?.tintColor = hasText ? .systemBlue : .systemGray
    }
    
    // MARK: - DELEGATE FUNC
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        guard let text = textField.text else { return true }
        tapAction?(text)
        return true
    }

    // MARK: - PADDING
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 + rightViewWidth))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 + rightViewWidth))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 + rightViewWidth))
    }
}
