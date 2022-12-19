//
//  RefreshService.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/12/03.
//


import Foundation
import Alamofire

struct RefreshService {
    // 싱클턴 패턴 - static 키워드로 shared라는 프로퍼티에 싱글턴 인스턴스 저장하여 생성
    // 여러 VC에서도 shared로 접근하면 같은 인스턴스에 접근할 수 있는 형태
    static let shared = RefreshService()
    
    //    let refresh = KeyChain.shared.read(key: "refreshToken")
    //    let access = KeyChain.shared.read(key: "accessToken")
    
    
    func doRefreshToken(completion : @escaping (NetworkResult<Any>) -> Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization" : "Bearer \(String(describing: KeyChain.shared.read(key: "accessToken")))"
        ]
        
        func makeParameter() -> Parameters
        {
            return ["refreshToken" : "\(String(describing: KeyChain.shared.read(key: "refeshToken")))" ]
        }
        
        let URL = "http://3.36.170.161:8080/api/user/login/refresh"
        
        let dataRequest = AF.request(URL,
                                     method: .post,
                                     parameters: makeParameter(),
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
        
        guard let decodedData = try? decoder.decode(RefeshResponse.self, from: data) else { return .pathErr}
        
        switch statusCode {
            
        case 200: return .success(decodedData.data) // 성공
        case 400: return .requestErr(decodedData.data) // 실패
            //        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    
    
}

