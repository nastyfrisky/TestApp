//
//  AuthorizationViewController.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 28.08.2022.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let networkService = NetworkService()
    private let emailTextField = TextInputField(textLabel: "Введите ваш email:")
    private let passwordTextField = TextInputField(textLabel: "Введите пароль:")
    private let authorizationButton = UIButton()
    private let stackView = UIStackView()
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Авторизация"
        navigationItem.hidesBackButton = true
        
        authorizationButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
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
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        view.addSubview(stackView)
        view.addSubview(authorizationButton)
    }
    
    private func setupSubviews() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24
        stackView.distribution = .fillProportionally
        
        authorizationButton.setTitle("Авторизоваться", for: .normal)
        authorizationButton.layer.cornerRadius = 10
        authorizationButton.clipsToBounds = true
        authorizationButton.backgroundColor = .init(red: 0.29, green: 0.45, blue: 0.65, alpha: 1.0)
        
        passwordTextField.textField.isSecureTextEntry = true
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            authorizationButton.heightAnchor.constraint(equalToConstant: 40),
            authorizationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorizationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authorizationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
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
        
        if !validateEmpty(textField: passwordTextField) { invalidValue = true }
        
        guard !invalidValue else { return }
        networkService.login(userData: .init(
            email: email,
            password: passwordTextField.textField.text ?? ""
        )) { [weak self] result in
            switch result {
            case .failure:
                self?.showToast(message: "Ошибка от сервера", seconds: 5.0)
            case .success:
                let nextVC = ProfileViewController()
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
