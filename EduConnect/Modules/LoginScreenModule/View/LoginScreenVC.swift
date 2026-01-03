//
//  LoginScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit

protocol LoginScreenViewProtocol: AnyObject { }

final class LoginScreenVC: UIViewController {

    var presenter: LoginScreenPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI() { }
}

extension LoginScreenVC: LoginScreenViewProtocol { }
