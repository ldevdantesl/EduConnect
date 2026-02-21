//
//  DiffableCollectionViewContainer.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit
import SnapKit

final class DiffableCollectionViewContainer<Section: Hashable, Item: Hashable>: UIView, UICollectionViewDelegate {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    
    // MARK: - Properties
    let collectionView: UICollectionView
    var resignsFirstResponderOnScroll: Bool = false
    var adjustsForKeyboard: Bool = false
    
    // MARK: - PRIVATE VAR
    private(set) var diffableDataSource: DataSource!
    private var didSelectHandler: ((IndexPath) -> Void)?
    
    // MARK: - LIFECYCLE
    init(
        layout: UICollectionViewLayout,
    ) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if adjustsForKeyboard {
            setupKeyboardObservers()
        }
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        collectionView.delegate = self
    }
    
    // MARK: - Public API
    func configureDataSource(cellProvider: @escaping DataSource.CellProvider) {
        diffableDataSource = DataSource(
            collectionView: collectionView,
            cellProvider: cellProvider
        )
    }
    
    func scrollToTop(animated: Bool = true, animationDuration: TimeInterval = 1, completion: (() -> Void)? = nil) {
        guard collectionView.numberOfSections > 0 else {
            completion?()
            return
        }
        if animated {
            UIView.animate(withDuration: animationDuration) { [weak self] in
                self?.collectionView.setContentOffset(.zero, animated: false)
            } completion: { _ in
                completion?()
            }
        } else {
            collectionView.setContentOffset(.zero, animated: false)
            completion?()
        }
    }
    
    func getSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        diffableDataSource.snapshot()
    }
    
    func setSupplementaryViewProvider(_ provider: @escaping DataSource.SupplementaryViewProvider) {
        diffableDataSource.supplementaryViewProvider = provider
    }
    
    func setDidSelectHandler(_ handler: @escaping (IndexPath) -> Void) {
        didSelectHandler = handler
    }
    
    func reapplyCurrentSnapshot() {
        guard var snapshot = diffableDataSource?.snapshot() else { return }
        snapshot.reloadSections(snapshot.sectionIdentifiers)
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func reloadData() {
        var snapshot = diffableDataSource.snapshot()
        snapshot.reloadSections(snapshot.sectionIdentifiers)
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func reloadSection(section: Section) {
        var snapshot = diffableDataSource.snapshot()
        snapshot.reloadSections([section])
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func applySnapshot(
        sections: [Section],
        itemsBySection: [Section: [Item]],
        animated: Bool = true
    ) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(itemsBySection[$0] ?? [], toSection: $0)
        }
        diffableDataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    func reconfigureItems(_ items: [Item], animated: Bool = true) {
        guard var snapshot = diffableDataSource?.snapshot() else { return }
        snapshot.reconfigureItems(items)
        diffableDataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    func snapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        diffableDataSource.snapshot()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectHandler?(indexPath)
    }
    
    // MARK: - Registration
    func registerCell<T: UICollectionViewCell>(
        _ cellType: T.Type,
        reuseID: String
    ) {
        collectionView.register(cellType, forCellWithReuseIdentifier: reuseID)
    }
    
    func registerSupplementary<T: UICollectionReusableView>(
        _ viewType: T.Type,
        kind: String,
        reuseID: String
    ) {
        collectionView.register(
            viewType,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: reuseID
        )
    }
    
    // MARK: - DELEGATE
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard resignsFirstResponderOnScroll else { return }
        scrollView.endEditing(true)
    }
    
    // MARK: - Keyboard
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let window = window
        else { return }
        
        let bottomInset = frame.height - (window.safeAreaInsets.bottom) + 50
        UIView.animate(withDuration: duration) {
            self.collectionView.contentInset.bottom = bottomInset
            self.collectionView.verticalScrollIndicatorInsets.bottom = bottomInset
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        UIView.animate(withDuration: duration) {
            self.collectionView.contentInset.bottom = 0
            self.collectionView.verticalScrollIndicatorInsets.bottom = 0
        }
    }
}
