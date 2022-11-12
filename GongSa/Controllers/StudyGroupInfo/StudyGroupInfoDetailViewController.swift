//
//  StudyGroupInfoDetailViewController.swift
//  GongSa
//
//  Created by taechan on 2022/11/12.
//

import UIKit
import SnapKit

struct Comment {
    let user: String
    let comment: String
    let date: String
}

final class StudyGroupInfoDetailViewController: UIViewController {
    // MARK: - Properties
    var items: [Comment] = [Comment(user: "김공사", comment: "네 나옵니다. 2021년까지 출제되었어요.", date: "2022.10.11"),
                            Comment(user: "김공사", comment: "네 나옵니다. 2021년까지 출제되었어요.", date: "2022.10.11"),
                            Comment(user: "김공사", comment: "네 나옵니다. 2021년까지 출제되었어요.", date: "2022.10.11"),]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "소방공무원 문제에 이거 나오나요?"
        label.font = UIFont.pretendard(size: 16, family: .bold)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지 이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지이 왕이 원의 제국대장공주와 결혼하여 고려는 원의 부마국이 되었고, 도병마사는 도평의사사로 개편되었다.도병마사는 도평의사지"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private lazy var commentTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gsLightGray.cgColor
        tf.attributedPlaceholder = NSAttributedString(
            string: "댓글을 입력해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gsGreen]
        )
        tf.setPadding(left: 24)
        return tf
    }()
    
    private var commentTableView = UITableView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(commentTextField)
        view.addSubview(commentTableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(84)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(214)
            make.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(24)
            make.height.equalTo(400)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).inset(-10)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(commentTextField.snp.bottom)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func configureTableView() {
        commentTableView = UITableView(frame: .zero, style: .grouped)
        commentTableView.register(StudyGroupInfoDetailTableViewCell.self, forCellReuseIdentifier: StudyGroupInfoDetailTableViewCell.identifier)
        commentTableView.delegate   = self
        commentTableView.dataSource = self
        commentTableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Selectors
}

extension StudyGroupInfoDetailViewController: UITableViewDelegate {
    
}

extension StudyGroupInfoDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudyGroupInfoDetailTableViewCell.identifier,
                                                       for: indexPath) as? StudyGroupInfoDetailTableViewCell else { return UITableViewCell() }
        
        // configure cell
        let index = indexPath.row
        cell.configure(comment: self.items[index])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
