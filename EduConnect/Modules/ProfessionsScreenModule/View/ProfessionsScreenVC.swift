//
//  ProfessionsScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

import UIKit

protocol ProfessionsScreenViewProtocol: AnyObject {
}

final class ProfessionsScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ProfessionsScreenPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProfessionsScreenVC: ProfessionsScreenViewProtocol {
}
