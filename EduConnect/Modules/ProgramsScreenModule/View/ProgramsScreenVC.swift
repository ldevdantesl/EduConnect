//
//  ProgramsScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

import UIKit

protocol ProgramsScreenViewProtocol: AnyObject {
}

final class ProgramsScreenVC: UIViewController {

    var presenter: ProgramsScreenPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProgramsScreenVC: ProgramsScreenViewProtocol {
}
