//
//  StudyroomQuestionService.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/12.
//


import Foundation
import Alamofire

struct StudyroomQuestionService{
    
    static let shared = StudyroomQuestionService()
    
    private func makeParameter(title : String, content : String, grpID: Int ) -> Parameters
    {
        return ["groupUID": grpID,
                "title" : title,
                "content" : content
                ]
    }
    
    let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Authorization" : "Bearer \(String(describing: KeyChain.shared.read(key: "accessToken")))"]
    
    
    func postQuestion(title: String,
                      content: String,
                      groupID: Int,
                      completion : @escaping (NetworkResult<Any>) -> Void)
    {
        
        let URL = "http://3.36.170.161:8080/api/question"
        let dataRequest = AF.request(URL,
                                     method: .post,
                                     parameters: makeParameter(title: title, content: content, grpID: groupID),
                                     encoding: JSONEncoding.default,
                                     headers: headers)
        
        // 통신중
        dataRequest.responseData { dataResponse in
            
            dump(dataResponse)
            
            switch dataResponse.result {
            // 통신 성공
            case .success:
                // dataResponse.statusCode 는 Response의 statuscode
                guard let statusCode = dataResponse.response?.statusCode else {return}
                
                // response의 결과 데이터
                guard let value = dataResponse.value else {return}
                
                // judgeStatus에 statuscode와 value(결과 데이터) 실어서 보냄
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            // 통신 실패의 경우 completion에 pathErr값을 담아서 뷰컨으로 날려주기
            // 타임아웃 / 통신 불가능의 상태로 통신 자체에 실패한 경우
            case .failure: completion(.pathErr)
                guard (dataResponse.response?.statusCode) != nil else {return}
            }
        }
        
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(StudyroomQuestionResponse.self, from: data) else { return .pathErr}
        
        switch statusCode {
            
        case 201: return .success(decodedData.data) // 성공
        case 403: return .requestErr(decodedData.msg) // 실패
        case 400: return .networkFail
        case 401: return .loginErr(decodedData.location)
            
            //        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
}

