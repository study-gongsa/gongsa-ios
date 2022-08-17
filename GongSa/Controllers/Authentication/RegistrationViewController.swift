//
//  RegistrationViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Selectors

    @available(iOS 13.0, *)
    @objc func handleRegistration() {

        // TODO: 유저 register 코드
        
        // MainTabViewController 가져와서 인증, UI 그리고 dismiss
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first(where: { $0.isKeyWindow }) else { return }
        guard let tab = window.rootViewController as? MainTabViewController else { return }
        
        tab.authenticateUserAndConfigureUI()

        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Helpers
}
