//
//  HomeScreenMainTabInfoCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import UIKit
import SnapKit

struct HomeScreenMainTabInfoCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "HomeScreenMainTabInfoCell"
}

final class HomeScreenMainTabInfoCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: HomeScreenMainTabInfoCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let welcomeMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
        Поздравляем вас с первым шагом на пути к поступлению в один из лучших вузов Казахстана!\nЗдесь вы сможете выбрать учебное заведение,подать документы и отслеживать весь процесс поступления.
        """
        label.font = ECFont.font(.regular, size: 16)
        return label
    }()
    
    private let adviceSectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Вот несколько советов, чтобы начать:"
        label.font = ECFont.font(.bold, size: 17)
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
            * Этот раздел — ваша личная панель. После того как вы добавите вуз в список, вы сможете отслеживать прогресс своей заявки.
            * Все вузы потребуют от вас ответов на общие вопросы в анкете. Для подачи заявки в вуз перейдите в раздел Поиск вузов.
            * Как только вы добавите вуз, сможете завершить и отправить вашу заявку в разделе Мои вузы.\n\nМы всегда готовы помочь вам на каждом шаге! Если у вас возникнут вопросы, вы можете обратиться в наш Центр поддержки абитуриентов или связаться с нами в любое время.
        """
        label.font = ECFont.font(.regular, size: 16)
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [welcomeMessageLabel, adviceSectionLabel, adviceLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Constants.spacing
        return stack
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
        guard let vm = vm as? HomeScreenMainTabInfoCellViewModel else { return }
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
