//
//  AuthService.swift
//  GongSa
//
//  Created by taechan on 2022/08/18.
//

import Foundation
import Alamofire

/// API Errors
enum APIError: Error {
    case noDataReturned
    case invalidURL
    case unableToSendMail
    case invalidMail
    case invalidInput
    case invalidCode
}

class AuthService {
    static let shared = AuthService()

    struct Constants {
        static let baseURL = "http://3.36.170.161:8080/"
    }

    /// API Endpoints
    private enum Endpoint: String {
        case code   = "api/user/code"
        case signUp = "api/user/join"
        case signIn = "api/user/login"
        case mail   = "api/user/mail/join"
    }

    /// Sign up request
    /// - Parameters:
    ///   - completion: Callback for result
    public func signUp(params: [String: String], completion: @escaping (DataResponse<SignUpResponse, AFError>) -> Void) {
        let urlString = Constants.baseURL + Endpoint.signUp.rawValue
        AF.request(urlString, method: .post, parameters: params, encoder: .json).responseDecodable(of: SignUpResponse.self) { response in
            debugPrint("DEBUG - authService: signUp ", response.result)
            completion(response)
        }
    }

    /// mail sending request
    /// - Parameters:
    ///   - completion: Callback for result
    public func sendMail(params: [String: String], completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.baseURL + Endpoint.mail.rawValue
        AF.request(urlString, method: .patch, parameters: params, encoder: .json).validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// code authentication request
    /// - Parameters:
    ///   - completion: Callback for result
    public func authenticateCode(params: [String: String], completion: @escaping (DataResponse<SignUpResponse, AFError>) -> Void) {
        let urlString = Constants.baseURL + Endpoint.code.rawValue
        AF.request(urlString, method: .patch, parameters: params, encoder: .json).responseDecodable(of: SignUpResponse.self) { response in
            debugPrint("DEBUG - authService: authenticateCode ", response.result)
            completion(response)
        }
    }

    /// Try to create url for endpoint
    /// - Parameters:
    ///   - endpoint: Endpoint to create for
    ///   - queryParams: Additional query arguments
    /// - Returns: Optional URL
    private func url(
        for endpoint: Endpoint
    ) -> URL? {
        let urlString = Constants.baseURL + endpoint.rawValue
        return URL(string: urlString)
    }
}
