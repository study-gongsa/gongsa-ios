//
//  APIService.swift
//  GongSa
//
//  Created by taechan on 2022/08/18.
//

import Foundation
import Alamofire

struct StudyGroupResponse: Decodable {
    let location: String?
    let msg: String?
    let data: DataClass?
}

struct DataClass: Decodable {
    let studyGroupList: [StudyGroup]
}

struct StudyGroup: Decodable {
    let studyGroupUID: Int
    let imgPath: String
    let name: String
    let isCam: Bool
    let createdAt: Int64
    let expiredAt: Int64
}

struct CustomGetEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }
}

class APIService {
    static let shared = APIService()
    
    struct Constants {
        static let baseURL = "http://3.36.170.161:8080/"
    }
    
    /// API Endpoints
    private enum Endpoint: String {
        case recommend = "api/study-group/recommend"
        case search = "api/study-group/search"
        case searchByCode = "api/study-group/code/"
        case searchByUID = "api/study-group/"
        case create = "api/study-group"
        case getMyRanking = "api/study-group/my-ranking"
    }
    
    /// recommend request
    /// - Parameters:
    ///   - completion: Callback for result
    public func recommend(params: [String: String],
                          headers: HTTPHeaders,
                          completion: @escaping (DataResponse<StudyGroupResponse, AFError>) -> Void) {
        let urlString = Constants.baseURL + Endpoint.recommend.rawValue
        print("debug - urlstring", urlString)
        AF.request(urlString,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.queryString,
                   headers: headers)
        .responseDecodable(of: StudyGroupResponse.self) { response in
            completion(response)
        }
    }
    
    public func search(params: [String: Any],
                       headers: HTTPHeaders,
                       completion: @escaping (DataResponse<StudyGroupResponse, AFError>) -> Void) {
        let urlString = Constants.baseURL + Endpoint.search.rawValue
        print("debug - urlstring", urlString)
        AF.request(urlString,
                   method: .get,
                   parameters: params,
                   encoding: CustomGetEncoding(),
                   headers: headers)
        .responseDecodable(of: StudyGroupResponse.self) { response in
            print("DEBUG -  request", response.request)
            completion(response)
        }
    }
}
