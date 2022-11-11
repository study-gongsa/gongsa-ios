//
//  Observable.swift
//  GongSa
//
//  Created by taechan on 2022/08/03.
//

import Foundation

class Observable<T> {

    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    init(_ value: T) {
        self.value = value
    }
}
