//
//  UIImageView.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/04.
//

import Foundation
import UIKit
import Alamofire


extension UIImageView {
    func imageDownload(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Header
        var token = "Bearer "
        if let tk = KeyChain.shared.read(key: "accessToken") {
            token = "Bearer" + tk
        }
        
        request.addValue( token, forHTTPHeaderField: "Authorization")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                print("Download image fail : \(url)")
                return
            }
            
            DispatchQueue.main.async() { [weak self] in
                print("Download image success \(url)")
                
                self?.contentMode = mode
                self?.image = image
            }
        }.resume()
    }
    
    
    
    func getImageRequest(url: URL){
        
        // [http 요청 주소 지정]
//        let url = "https://test.app.ac.kr/pro_image?"
        let url = url
        
        var token = "Bearer "
        if let tk = KeyChain.shared.read(key: "accessToken") {
            token = "Bearer" + tk
        }
        
        
        // [http 요청 헤더 지정]
        let header : HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : token
        ]

        AF.request(
            url, // [주소]
            method: .get, // [전송 타입]
//            parameters: queryString,
            encoding: URLEncoding.queryString, // [인코딩 스타일]
            headers: header // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                   
                    // [비동기 작업 수행]
                    DispatchQueue.main.async {
                        
                        // [UIImageView : 이미지 뷰에 사진 표시 실시]
                        let image = UIImage(data: res)
                        self.image = image
//                        self.imageView.image = image
                    }
                }
                catch (let err){
                    print("-------------------------------")
                    print("catch :: ", err.localizedDescription)
                    print("====================================")
                    print("")
                }
                break
            case .failure(let err):
                print("")
                print("-------------------------------")
                print("응답 코드 :: ", response.response?.statusCode ?? 0)
                print("-------------------------------")
                print("에 러 :: ", err.localizedDescription)
                print("====================================")
                print("")
                break
            }
        }
    }
    

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
