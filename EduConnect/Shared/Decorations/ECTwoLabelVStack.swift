//
//  ECTwoLabelVStack.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 25.02.2026.
//

import UIKit
import SnapKit

final class ECTwoLabelVStack: UIView {
    
    let firstLineLabel: UILabel = UILabel()
    let secondLineLabel: UILabel = UILabel()
    
    private(set) lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstLineLabel, secondLineLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
