//
//  BasePopupViewController.swift
//  GongSa
//
//  Created by taechan on 2022/09/26.
//

import UIKit

class BasePopupViewController: UIViewController {
    // MARK: - Properties

    public let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.pretendard(size: 20, family: .bold)
        return title
    }()

    public let bottomButton: UIButton = {
        let button = UIButton.main(withTitle: "")
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

    }

    // MARK: - Helpers

    // MARK: - Selectors
}
