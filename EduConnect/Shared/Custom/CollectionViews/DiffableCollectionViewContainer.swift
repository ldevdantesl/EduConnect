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
    private let collectionView: UICollectionView
    private var diffableDataSource: DataSource!
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

    func snapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        diffableDataSource.snapshot()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectHandler?(indexPath)
    }
}
