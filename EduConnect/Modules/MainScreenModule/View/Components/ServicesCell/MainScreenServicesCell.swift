//
//  MainScreenServicesCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.02.2026.
//

import UIKit
import SnapKit

struct MainScreenServicesCellViewModel {
    let didTapProfession: (() -> Void)?
    let didTapUniversity: (() -> Void)?
    let didTapCalendar: (() -> Void)?
    
    init(didTapProfession: (() -> Void)? = nil, didTapUniversity: (() -> Void)? = nil, didTapCalendar: (() -> Void)? = nil) {
        self.didTapProfession = didTapProfession
        self.didTapUniversity = didTapUniversity
        self.didTapCalendar = didTapCalendar
    }
}

final class MainScreenServicesCell: UICollectionViewCell {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 20.0
        static let itemWidth = 135.0
        static let itemHeight = 170.0
        static let backColor = UIColor.hex("#795CED")
    }
    
    private struct Item {
        let title: String
        let image: ImageConstants
        let onTapAction: (() -> Void)?
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenServicesCellViewModel?
    private var items: [Item] = []
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сервисы для\nпоступающих"
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: Constants.itemWidth, height: Constants.itemHeight)
        layout.minimumLineSpacing = 60
        let sideInset = (SharedConstants.screenWidth - Constants.itemWidth) / 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(cell: MainScreenServicesItem.self)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.decelerationRate = .fast
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyFloatingShadow()
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: MainScreenServicesCellViewModel) {
        self.viewModel = vm
        self.items = [
            .init(title: "Выбор профессии", image: .mainServicesProfessionImage, onTapAction: vm.didTapProfession),
            //.init(title: "Тесты", image: .mainServicesTestImage, onTapAction: vm.didTapTests),
            .init(title: "Помощь в выборе вуза", image: .mainServicesUniversityImage, onTapAction: vm.didTapUniversity),
            .init(title: "Календарь", image: .mainServicesCalendarImage, onTapAction: vm.didTapCalendar)
        ]
        
        collectionView.reloadData()
        DispatchQueue.main.async { [weak self] in
            self?.setInitialOffset()
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing * 1.5)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }

        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.itemHeight)
            $0.bottom.equalToSuperview().offset(-Constants.spacing * 1.5)
        }
    }
    
    private func setInitialOffset() {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        guard itemCount > 1 else { return }
        
        collectionView.scrollToItem(
            at: IndexPath(item: 1, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
    }
}

extension MainScreenServicesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenServicesItem.identifier, for: indexPath) as? MainScreenServicesItem else { return UICollectionViewCell() }
        let item = items[indexPath.row]
        let vm = MainScreenServicesItemViewModel(title: item.title, image: item.image, onTapAction: item.onTapAction)
        cell.configure(withVM: vm)
        return cell
    }
}

extension MainScreenServicesCell: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let itemWidth = layout.itemSize.width
        let spacing = layout.minimumLineSpacing
        let pageWidth = itemWidth + spacing

        let targetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let index = round(targetX / pageWidth)

        targetContentOffset.pointee.x = index * pageWidth - scrollView.contentInset.left
    }
}
