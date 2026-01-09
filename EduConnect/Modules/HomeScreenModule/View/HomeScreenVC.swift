//
//  HomeScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol HomeScreenViewProtocol: AnyObject {
}

final class HomeScreenVC: UIViewController {

    var presenter: HomeScreenPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
}

extension HomeScreenVC: HomeScreenViewProtocol {
}
