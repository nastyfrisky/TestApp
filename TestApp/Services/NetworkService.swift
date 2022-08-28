//
//  NetworkService.swift
//  TestApp
//
//  Created by Анастасия Ступникова on 28.08.2022.
//

import Foundation

final class NetworkService {
    enum LoadingError: Error {
        case wrongData
        case noData
    }
    
    // MARK: - Private Properties
    
    private let urlSession: URLSessionProtocol
    private let queue: Queue
    
    // MARK: - Initializers
    
    init(urlSession: URLSessionProtocol, queue: Queue) {
        self.urlSession = urlSession
        self.queue = queue
    }
    
    convenience init() {
        self.init(urlSession: URLSession.shared, queue: DispatchQueue.main)
    }
    
    // MARK: - Public Methods
    
    func register(
        userData: RegistrationRequest,
        completion: @escaping (Result<RegistrationResponse, LoadingError>
    ) -> Void) {
        guard let request = makeRequest(method: "registerUser", data: userData) else { return }
        executeTask(request: request, completion: completion)
    }
    
    func login(
        userData: LoginRequest,
        completion: @escaping (Result<LoginResponse, LoadingError>
    ) -> Void) {
        guard let request = makeRequest(method: "checkLogin", data: userData) else { return }
        executeTask(request: request, completion: completion)
    }
    
    // MARK: - Private Methods
    
    private func makeRequest<T: Encodable>(method: String, data: T) -> URLRequest? {
        guard let url = URL(string: "http://94.127.67.113:8099/\(method)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONEncoder().encode(data) else { return nil }
        request.httpBody = httpBody
        return request
    }
    
    private func executeTask<T: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<T, LoadingError>) -> Void
    ) {
        urlSession.makeDataTask(with: request) { [weak self] data, response, error in
            guard let data = data else {
                self?.callCompletion(completion, .failure(.noData))
                return
            }

            print(String(decoding: data, as: UTF8.self))
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                self?.callCompletion(completion, .failure(.wrongData))
                return
            }
            
            
            self?.callCompletion(completion, .success(decodedData))
        }.resume()
    }
    
    private func callCompletion<T>(_ completion: @escaping (T) -> Void, _ parameter: T) {
        queue.async { completion(parameter) }
    }
}
