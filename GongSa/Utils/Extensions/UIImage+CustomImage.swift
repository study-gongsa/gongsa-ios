//
//  UIImage+CustomImage.swift
//  GongSa
//
//  Created by taechan on 2022/09/03.
//

import UIKit

extension UIImage {
    static let errorMessage = "Image Not Found."

    static func home() -> UIImage {
        guard let image = UIImage(named: "home") else { fatalError(errorMessage) }
        return image
    }

    static func search() -> UIImage {
        guard let image = UIImage(systemName: "magnifyingglass") else { fatalError(errorMessage) }
        return image
    }
}
