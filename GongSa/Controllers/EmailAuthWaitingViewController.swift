//
//  EmailAuthWaitingViewController.swift
//  GongSa
//
//  Created by taechan on 2022/08/14.
//

import UIKit

class EmailAuthWaitingViewController: UIViewController {

    // MARK: - Properties
    public var emailAddress: String?

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        indicator.color = .gray
        indicator.startAnimating()
        // wdt 209, hgt 100
        indicator.transform = CGAffineTransform(scaleX: 4.5, y: 4.5)
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

        //         debug
        sendMail { response in
            switch response {
            case .success(let response):
                debugPrint("DEBUG - send mail success", response)
                let emailViewController = EmailAuthCodeViewController()
                emailViewController.emailAddress = self.emailAddress
                self.navigationController?.pushViewController(emailViewController, animated: true)
            case .failure(let error):
                debugPrint("DEBUG - send mail error", error)
            }
        }
    }

    // MARK: - Helpers
    private func sendMail(completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let emailAddress = self.emailAddress else {
            completion(.failure(APIError.unableToSendMail))
            return
        }
        let params = ["email": emailAddress]
        AuthService.shared.sendMail(params: params) { response in
            switch response {
            case .success(let response):
                completion(.success(response))
            case .failure:
                completion(.failure(APIError.unableToSendMail))
            }
        }
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

    private func configureUI() {

//        view.addSubview(loadingIndicator)
//        loadingIndicator.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 150, width: 100, height: 100)
//        loadingIndicator.center(inView: view, yConstant: -170)

        let stackView = UIStackView(arrangedSubviews: [loadingIndicator, helpLabel, helpSubLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering

        view.addSubview(stackView)
        stackView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: view.frame.height/5, paddingLeft: view.frame.width/4, width: 209, height: 168)// , paddingTop: 50, paddingBottom: 50)

        loadingIndicator.setContentHuggingPriority(.defaultLow, for: .vertical)
        helpLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        helpSubLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        //        loadingIndicator.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
        loadingIndicator.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
        helpLabel.anchor(top: loadingIndicator.bottomAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
        helpSubLabel.anchor(top: helpLabel.bottomAnchor, left: stackView.leftAnchor, bottom: stackView.bottomAnchor, right: stackView.rightAnchor, paddingTop: 12)
    }
}
