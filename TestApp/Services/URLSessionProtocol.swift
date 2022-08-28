//
//  URLSessionProtocol.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 28.08.2022.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    func makeDataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    func makeDataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completionHandler)
    }
}
