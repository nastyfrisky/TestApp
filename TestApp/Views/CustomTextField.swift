//
//  CustomTextField.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 27.08.2022.
//

import UIKit

final class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnd), for: .editingDidEnd)
        
        layer.borderColor = CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 0)
    }
    
    @objc private func editingBegan() {
        layer.borderColor = CGColor(red: 0.29, green: 0.45, blue: 0.65, alpha: 1)
    }
    
    @objc private func editingEnd() {
        layer.borderColor = CGColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    }
}

