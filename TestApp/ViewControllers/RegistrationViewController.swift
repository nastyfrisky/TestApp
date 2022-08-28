//
//  RegistrationViewController.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 27.08.2022.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let networkService = NetworkService()
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
    
    // MARK: - Override Methods
    
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
    
    // MARK: - Private Methods
    
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
        
        confirmationTextField.textField.isSecureTextEntry = true
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
        let emailValidationRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: strToValidate)
    }
    
    private func validateEmpty(textField: ValidatableTextField) -> Bool {
        guard (textField.textField.text ?? "").isEmpty else { return true }
        highlightInvalidValues(textField: textField)
        return false
    }
    
    private func highlightInvalidValues(textField: ValidatableTextField) {
        textField.textField.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
    @objc private func buttonTap() {
        var invalidValue = false
        
        guard let email = emailTextField.textField.text else {
            return
        }
        
        if !isValidEmailAddress(strToValidate: email) {
            highlightInvalidValues(textField: emailTextField)
            
            invalidValue = true
        }
        
        Array<ValidatableTextField>([
            surnameTextField,
            nameTextField,
            patronymicTextField,
            passwordTextField,
            confirmationTextField
        ]).forEach {
            if !validateEmpty(textField: $0) { invalidValue = true }
        }
        
        guard !invalidValue else { return }

        networkService.register(userData: .init(
            email: email,
            firstname: (nameTextField.textField.text ?? ""),
            lastname: (surnameTextField.textField.text ?? ""),
            password: (passwordTextField.textField.text ?? "")
        )) { [weak self] result in
            switch result {
            case .failure:
                self?.showToast(message: "Ошибка от сервера", seconds: 5.0)
            case .success:
                let nextVC = AuthorizationViewController()
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
