//
//  PopUpView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.01.2026.
//

import UIKit
import SnapKit

// MARK: - Protocol
protocol PopUpViewModel {
    var onClose: (() -> Void)? { get }
}

// MARK: - PopUpView
open class PopUpView: UIView {
    
    // MARK: - Properties
    private let viewModel: PopUpViewModel
    private let closesOnBackgroundTap: Bool
    private let animationDuration: TimeInterval
    
    // MARK: - UI Components
    private lazy var blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    public let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - Initialization
    init(
        viewModel: PopUpViewModel,
        closesOnBackgroundTap: Bool = true,
        animationDuration: TimeInterval = 0.5
    ) {
        self.viewModel = viewModel
        self.closesOnBackgroundTap = closesOnBackgroundTap
        self.animationDuration = animationDuration
        super.init(frame: .zero)
        setupUI()
    }
    
    deinit {
        #if DEBUG
        print("\(String(describing: type(of: self))) deinited")
        #endif
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.top.greaterThanOrEqualTo(safeAreaLayoutGuide).offset(20)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-20)
        }
    }
    
    // MARK: - Public Methods
    public func show(in parentView: UIView) {
        parentView.addSubview(self)
        
        snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alpha = 0
        contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) { [weak self] in
            self?.alpha = 1
            self?.contentView.transform = .identity
        }
    }
    
    public func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: { [weak self] in
                self?.alpha = 0
                self?.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    .concatenating(CGAffineTransform(translationX: 0, y: 30))
            },
            completion: { [weak self] _ in
                self?.removeFromSuperview()
                self?.viewModel.onClose?()
                completion?()
            }
        )
    }
    
    // MARK: - Actions
    @objc private func didTapBackground() {
        guard closesOnBackgroundTap else { return }
        dismiss()
    }
}
