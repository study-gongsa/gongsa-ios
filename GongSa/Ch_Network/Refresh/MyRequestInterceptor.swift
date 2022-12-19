//
//  MyRequestInterceptor.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/12/03.
//

import Foundation


import Foundation
import Alamofire

final class MyRequestInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("https://api.agify.io") == true,
              let accessToken = KeyChain.shared.read(key: "accessToken") else {
            completion(.success(urlRequest))
            return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        //
        RefreshService.shared.doRefreshToken() { result in
            switch result
            {
            case.success(let userdata):
                print("토큰 갱신 통신 성공")
                
                if let data = userdata as? RefreshDataClass {
                    print(data)
                    let accessToken = data.accessToken
                    
                    // keychain 저장
                    KeyChain.shared.delete(key: "accessToken")
                    KeyChain.shared.create(key: "accessToken", token: accessToken)
                    print("Keychain 토큰 갱신 성공")
                    
                }
                
            case .requestErr(_):
                // 토큰 만료
                
                let rootVC = LoginViewController() // 시작할 VC를 넣어주면 됩니다
                let navigationController = UINavigationController(rootViewController: rootVC)
                
                let scenes = UIApplication.shared.connectedScenes
                let windowScene = scenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                window?.rootViewController = navigationController
//                UIApplication.shared.windows.first {$0.isKeyWindow}?.rootViewController = navigationController
//                UIApplication.shared.windows.first!.rootViewController = navigationController
//                UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController?.present(navigationController, animated: true, completion: nil)
//                view?.window?.rootViewController = navigationController
            default :
                print("Token ERROR")
            }
        }
        
        
    }
}
