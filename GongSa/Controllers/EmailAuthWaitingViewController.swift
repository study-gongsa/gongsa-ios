//
//  EmailAuthWaitingViewController.swift
//  GongSa
//
//  Created by taechan on 2022/08/14.
//

import UIKit

class EmailAuthWaitingViewController: UIViewController {

    // MARK: - Properties
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        indicator.color = .gray
        indicator.startAnimating()
        // wdt 209, hgt 100
        indicator.transform = CGAffineTransform(scaleX: 5, y: 5)
        return indicator
    }()

    private let helpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 16, family: .Bold)
        label.textColor = UIColor.gsBlack
        label.text = "이메일 확인중입니다"
        label.textAlignment = .center
        return label
    }()

    private let helpSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(size: 14, family: .Medium)
        label.textColor = UIColor.gsDarkGray
        label.text = "승인은 최대 1시간 소요될 수 있습니다."
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.navigationController?.pushViewController(EmailAuthCodeViewController(), animated: true)
//              self.performSegue(withIdentifier: "leadingToTutorial", sender: self)
         })
    }

    private func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        backButton.tintColor = UIColor.gsLightGray
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "이메일 인증"
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.gsBlack]
    }

    // MARK: - Helpers
    private func configureUI() {

        view.addSubview(loadingIndicator)
        loadingIndicator.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 150, width: 150, height: 150)

        let stackView = UIStackView(arrangedSubviews: [helpLabel, helpSubLabel])
        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally

        view.addSubview(stackView)
        stackView.anchor(top: loadingIndicator.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 550)

//        loadingIndicator.setContentHuggingPriority(.defaultLow, for: .vertical)
//        helpLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        helpSubLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

//        loadingIndicator.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
        helpLabel.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)

        helpSubLabel.anchor(top: helpLabel.bottomAnchor, left: stackView.leftAnchor, bottom: stackView.bottomAnchor, right: stackView.rightAnchor)
    }
}
