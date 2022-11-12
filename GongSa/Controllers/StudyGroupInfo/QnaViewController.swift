//
//  QnaViewController.swift
//  GongSa
//
//  Created by taechan on 2022/10/31.
//

import UIKit
import SnapKit

struct Qna {
    let title: String
    let contents: String
    let date: String
    let isAnswered: Bool
}

final class QnaViewController: UIViewController {
    
    // MARK: - Properties
    
    var qnas: [Qna] = [Qna(title: "test title", contents: "test contents", date: "test date", isAnswered: true),
                       Qna(title: "test title", contents: "test contents", date: "test date", isAnswered: true),
                       Qna(title: "test title", contents: "test contents", date: "test date", isAnswered: true),
                       Qna(title: "test title", contents: "test contents", date: "test date", isAnswered: true),
                       Qna(title: "test title", contents: "test contents", date: "test date", isAnswered: true),
                       Qna(title: "test title", contents: "test contents", date: "test date", isAnswered: true),
    ]
    
    private let titleLabel: UILabel = {
        return UILabel.customLabel(with: "그룹 내 질문 모아보기", color: .black, fontSize: 24, fontFamily: .bold)
    }()
    
    private lazy var qnaButton: UIButton = {
        return UIButton.main(withTitle: "Q&A")
    }()
    
    private let qnaTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(QnaTableViewCell.self, forCellReuseIdentifier: QnaTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        /// add subviews
        view.addSubview(titleLabel)
        view.addSubview(qnaButton)
        view.addSubview(qnaTableView)
        
        /// title label
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(204)
            make.height.equalTo(29)
        }
        
        /// qna button
        qnaButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.right.equalToSuperview().inset(24)
            make.width.equalTo(49)
            make.height.equalTo(28)
        }
        /// qna TableView
        qnaTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        qnaTableView.delegate = self
        qnaTableView.dataSource = self
    }
    
    
    // MARK: - Selectors
    
}

extension QnaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.qnas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QnaTableViewCell.identifier, for: indexPath) as? QnaTableViewCell else { return UITableViewCell() }
        
        cell.configure(qna: self.qnas[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }
}

extension QnaViewController: UITableViewDelegate {
    
}
