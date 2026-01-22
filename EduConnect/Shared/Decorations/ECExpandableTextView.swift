import UIKit
import SnapKit

final class ECExpandableTextView: UITextView {
    
    // MARK: - PROPERTIES
    var placeholder: String? {
        didSet { placeholderLabel.text = placeholder }
    }
    
    var minHeight: CGFloat = 100 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    var maxHeight: CGFloat = 300
    
    // MARK: - OVERRIDDEN PROPERTIES
    override var intrinsicContentSize: CGSize {
        let size = sizeThatFits(CGSize(width: bounds.width, height: .infinity))
        let height = min(max(size.height, minHeight), maxHeight)
        
        isScrollEnabled = size.height > maxHeight
        
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    override var text: String! {
        didSet { textDidChange() }
    }
    
    override var font: UIFont? {
        didSet { placeholderLabel.font = font }
    }
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .placeholderText
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        isScrollEnabled = false
        font = .systemFont(ofSize: 16)
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        setupPlaceholder()
        addDoneAccessory()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }
    
    private func addDoneAccessory() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flex = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let done = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneTapped)
        )

        toolbar.items = [flex, done]
        inputAccessoryView = toolbar
    }
    
    private func setupPlaceholder() {
        addSubview(placeholderLabel)
        placeholderLabel.font = font
        
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(textContainerInset.top)
            $0.leading.equalToSuperview().offset(textContainerInset.left + 4)
            $0.trailing.equalToSuperview().offset(-textContainerInset.right - 4)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
        invalidateIntrinsicContentSize()
    }
    
    @objc private func doneTapped() {
        resignFirstResponder()
    }
}
