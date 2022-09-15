//
//  LoginDataManager.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/09/06.
//

import Foundation
import Alamofire

class LoginDataManager {
    
    func postLogin(_ parameters: LoginRequest, delegate: LoginViewController) {
//
        //        AF.request("http://3.36.170.161:8080/api/user/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
        //            .validate()
        //            .responseDecodable(of: LoginResponse.self) { response in
        //            }
        //    }
        let url = "http://3.36.170.161:8080/api/user/login"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        let params = ["id":"아이디", "pw":"패스워드"] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
            case .failure(let error):
                print("error : \(error.errorDescription!)")
            }
        }
        
    }
    
    




/*

class LoginDataManger {
    func postLogin(_ parameters: LoginRequest, delegate: LoginViewController) {
        AF.request("http://3.36.170.161:8080/api/user/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // success
                    if response.isSuccess, let result = response.result {
                        guard let userinfo = response.result else { return }
                        
                        ACCESS_TOKEN = userinfo.jwt
                        
                        USER_ID = String(userinfo.userID)
                        
//                        let userid = userinfo.userID
                        
//                        let jwtToken = userinfo.jwt
                        UserDefaults.standard.setValue(USER_ID, forKey: "userID")
                        UserDefaults.standard.setValue(ACCESS_TOKEN, forKey: "X-ACCESS-TOKEN")
                        print("userinfo_login",USER_ID, ACCESS_TOKEN)
                        delegate.didSuccessSignIn(result)
                    }
                    // fail
                    else {
                        switch response.code {
                        case 2015: delegate.failedToRequest(message: "이메일을 입력해주세요.")
                        case 2016: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 2019: delegate.failedToRequest(message: "비밀번호를 입력해주세요.")
                        case 3014: delegate.failedToRequest(message: "비밀번호가 틀렸습니다.")
                        case 3015: delegate.failedToRequest(message: "없는 이메일 입니다.")
                        case 4000: delegate.failedToRequest(message: "데이터베이스 연결에 실패했습니다.")
                        default: delegate.failedToRequest(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                    
                }
            }
    }
}
*/
