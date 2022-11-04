//
//  UIImageView.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/04.
//

import Foundation
import UIKit



extension UIImageView {

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
