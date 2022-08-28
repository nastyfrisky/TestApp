//
//  CustomTextField.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 27.08.2022.
//

import UIKit

protocol ValidatableTextField {
    var currentText: String { get }
}

final class TextInputField: UIView, ValidatableTextField {
    var currentText: String {
        textField.text ?? ""
    }
    
    private let textField = CustomTextField()
    private let label = UILabel()
    
    init(textLabel: String) {
        super.init(frame: .zero)
        self.label.text = textLabel
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(label)
        addSubview(textField)
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
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
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
}
