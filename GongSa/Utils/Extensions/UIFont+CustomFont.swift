//
//  UIFont+CustomFont.swift
//  GongSa
//
//  Created by taechan on 2022/08/11.
//

import UIKit

extension UIFont {
    enum Family: String {
        case black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin
    }

    static func pretendard(size: CGFloat = 14, family: Family = .regular) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
