//
//  NetworkResult.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/09/15.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
    case loginErr(T)
    case authErr(T)
}
