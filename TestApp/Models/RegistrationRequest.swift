//
//  RegistrationRequest.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 28.08.2022.
//

struct RegistrationRequest: Encodable {
    let email: String
    let firstname: String
    let lastname: String
    let password: String
}
