//
//  Service.swift
//  ACTDigital
//
//  Created by Thiago Soares on 11/05/23.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
    case jsonError
    
    func messageError() -> String {
        switch self {
        case .jsonError:
            return "Problema com a conexão"
            
        case .network:
            return "Problema com a conexão"
            
        case .invalidURL:
            return "A pesquisa realizada de usuário não encontrou resultado."
        }
    }
}

class Service {
    private let baseURL = "https://api.github.com"
    static let sharedInstance = Service()
    
    enum CallType {
        case users(pagination: Int)
        case userDetail(login: String)
        case repo(login: String)
    }
    
    func callWithType(type: CallType) -> String {
        switch type {
        case .users(let pagination):
            return "\(baseURL)/users?per_page=\(pagination)"
            
        case .userDetail(let login):
            return "\(baseURL)/users/\(login)"
            
        case .repo(let login):
            return "\(baseURL)/users/\(login)/repos"
            
        }
    }
}

protocol ServiceProtocol {
    func fetchUsers(pagination: Int, callback: @escaping (Result<[User], ServiceError>) -> Void)
    func fetchUserDetail(login: String, callback: @escaping (Result<User, ServiceError>) -> Void)
    func fetchUserRepo(login: String, callback: @escaping (Result<[Repo], ServiceError>) -> Void)
}

extension Service: ServiceProtocol {
    func fetchUsers(pagination: Int, callback: @escaping (Result<[User], ServiceError>) -> Void) {
        guard let url = URL(string: callWithType(type: .users(pagination: pagination))) else {
            callback(.failure(.jsonError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(.jsonError))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    callback(.failure(.jsonError))
                    return
                }
            }
            guard let json = try? JSONDecoder().decode([User].self, from: data) else {
                callback(.failure(.jsonError))
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                callback(.success(json))
            }
        }
        task.resume()
        
    }
    
    func fetchUserDetail(login: String, callback: @escaping (Result<User, ServiceError>) -> Void) {
        guard let url = URL(string: callWithType(type: .userDetail(login: login))) else {
            callback(.failure(.jsonError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(.invalidURL))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    callback(.failure(.invalidURL))
                    return
                }
            }
            guard let json = try? JSONDecoder().decode(User.self, from: data) else {
                callback(.failure(.invalidURL))
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                callback(.success(json))
            }
        }
        task.resume()
        
    }
    
    
    func fetchUserRepo(login: String, callback: @escaping (Result<[Repo], ServiceError>) -> Void) {
        guard let url = URL(string: callWithType(type: .repo(login: login))) else {
            callback(.failure(.jsonError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(.invalidURL))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    callback(.failure(.invalidURL))
                    return
                }
            }
            guard let json = try? JSONDecoder().decode([Repo].self, from: data) else {
                callback(.failure(.invalidURL))
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                callback(.success(json))
            }
        }
        task.resume()
        
    }
}
