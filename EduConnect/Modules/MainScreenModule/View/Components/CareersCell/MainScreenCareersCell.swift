//
//  MainScreenApplyUniversityCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

struct MainScreenCareersCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = MainScreenCareersCell.identifier
    let universities: [ECUniversity]
    let didTapUniversity: ((ECUniversity) -> Void)?
    
    init(universities: [ECUniversity], didTapUniversity: ((ECUniversity) -> Void)? = nil) {
        self.universities = universities
        self.didTapUniversity = didTapUniversity
    }
}

final class MainScreenCareersCell: UICollectionViewCell, ConfigurableCellProtocol {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 20.0
        static let itemWidth = 135.0
        static let itemHeight = 170.0
        static let backColor = UIColor.hex("#795CED")
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenCareersCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let text = "Поступи в вузы\nКазахстана"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [ .font: ECFont.font(.bold, size: 24) ]
        )

        if let range = text.range(of: "Казахстана") {
            let nsRange = NSRange(range, in: text)
            attributed.addAttributes([.font: ECFont.font(.regular, size: 20)], range: nsRange)
        }
        
        let label = UILabel()
        label.attributedText = attributed
        label.textColor = .white
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
        cv.register(cell: MainScreenCareersItem.self)
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
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? MainScreenCareersCellViewModel else { return }
        self.viewModel = vm
        collectionView.reloadData()
        
        DispatchQueue.main.async { [weak self] in
            self?.setInitialOffset()
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = Constants.backColor
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

extension MainScreenCareersCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.universities.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCareersItem.identifier, for: indexPath) as? MainScreenCareersItem else { return UICollectionViewCell() }
        let item = viewModel?.universities[safe: indexPath.row] ?? ECUniversity.sample
        let vm = MainScreenCareersItemViewModel(university: item) { [weak self] in self?.viewModel?.didTapUniversity?($0) }
        cell.configure(withVM: vm)
        return cell
    }
}

extension MainScreenCareersCell: UICollectionViewDelegateFlowLayout {
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
