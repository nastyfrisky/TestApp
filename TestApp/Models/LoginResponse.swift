//
//  LoginResponse.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 28.08.2022.
//

struct LoginResponse: Decodable {
    let email: String
    let password: String
    let id: String
}
