//
//  PasswordTextField.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 27.08.2022.
//

import UIKit

final class PasswordTextField: UIView, ValidatableTextField {
    
    // MARK: - Public Properties
    
    var action = {}
    let textField = CustomTextField()
    
    // MARK: - Private Properties
    
    private let label = UILabel()
    private let button = UIButton()
    
    // MARK: - Initializers
    
    init(textLabel: String, image: UIImage?) {
        super.init(frame: .zero)
        self.label.text = textLabel
        self.button.setImage(image, for: .normal)
        
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(label)
        addSubview(textField)
        addSubview(button)
    }
    
    private func setupSubviews() {
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .darkGray
        
        textField.backgroundColor = .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
    }
    
    private func setupConstraints() {
        [button, label, textField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -5),
            button.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            button.topAnchor.constraint(equalTo: textField.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func buttonTap() {
       action()
    }
}
