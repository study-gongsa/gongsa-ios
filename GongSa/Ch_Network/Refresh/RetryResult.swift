//
//  RetryResult.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/12/03.
//

import Foundation

public enum RetryResult {
    /// Retry should be attempted immediately
    case retry
    case retryWithDelay(TimeInterval)
    case doNotRetry
    case doNotRetryWithError(Error)
    
    
}
