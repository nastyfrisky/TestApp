//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 28.08.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let logo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        logo.image = UIImage(named: "logo")
        view.addSubview(logo)
        
        setupConstraints()
    }

    private func setupConstraints() {
        logo.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
