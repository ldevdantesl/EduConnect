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
    
    // MARK: - PRIVATE VAR
    private(set) var diffableDataSource: DataSource!
    private var didSelectHandler: ((IndexPath) -> Void)?

    // MARK: - Init
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
}
