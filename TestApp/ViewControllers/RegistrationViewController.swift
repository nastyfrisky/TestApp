//
//  RegistrationViewController.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 27.08.2022.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private let surnameTextField = TextInputField(textLabel: "Введите фамилию:")
    private let nameTextField = TextInputField(textLabel: "Введите имя:")
    private let patronymicTextField = TextInputField(textLabel: "Введите отчество:")
    private let emailTextField = TextInputField(textLabel: "Введите ваш email:")
    private let passwordTextField = PasswordTextField(
        textLabel: "Введите пароль:",
        image: UIImage(systemName: "eye.slash")
    )
    private let confirmationTextField = TextInputField(textLabel: "Повторите пароль:")
    private let registrationButton = UIButton()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Регистрация"
        
        passwordTextField.action = { [weak self] in
            if self?.passwordTextField.textField.isSecureTextEntry == true {
                self?.passwordTextField.textField.isSecureTextEntry = false
                self?.confirmationTextField.textField.isSecureTextEntry = false
            } else {
                self?.passwordTextField.textField.isSecureTextEntry = true
                self?.confirmationTextField.textField.isSecureTextEntry = true
            }
        }
        
        registrationButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func addSubviews() {
        [
            surnameTextField,
            nameTextField,
            patronymicTextField,
            emailTextField,
            passwordTextField,
            confirmationTextField
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
        view.addSubview(registrationButton)
    }
    
    private func setupSubviews() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24
        stackView.distribution = .fillProportionally
        
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.layer.cornerRadius = 10
        registrationButton.clipsToBounds = true
        registrationButton.backgroundColor = .init(red: 0.29, green: 0.45, blue: 0.65, alpha: 1.0)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            registrationButton.heightAnchor.constraint(equalToConstant: 40),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registrationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func isValidEmailAddress(strToValidate: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"

        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)

        return emailValidationPredicate.evaluate(with: strToValidate)
    }
    
    private func validateEmpty(textField: ValidatableTextField) -> Bool {
        if textField.currentText.isEmpty {
            
        }
    }
    
    @objc private func buttonTap() {
        guard let email = emailTextField.textField.text else {
            return
        }
        
        if !isValidEmailAddress(strToValidate: email) {
            return
        }
        
        if email.isEmpty {
            return
        }
            || (surnameTextField.textField.text ?? "").isEmpty
            || (nameTextField.textField.text ?? "").isEmpty
            || (patronymicTextField.textField.text ?? "").isEmpty
            || (passwordTextField.textField.text ?? "").isEmpty
            || (confirmationTextField.textField.text ?? "").isEmpty {
            return
        }
    }
}
