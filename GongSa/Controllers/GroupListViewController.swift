//
//  GroupListViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit

class GroupListViewController: UIViewController {
    
    // MARK: - Properties
    var studyGroups: [StudyGroup] = []
    
    private let titleLabel: UILabel = {
        return UILabel.customLabel(with: "가입한 스터디 내역", color: .gsBlack, fontSize: 20, fontFamily: .bold)
    }()
    
    private let studyGroupTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(QnaTableViewCell.self, forCellReuseIdentifier: QnaTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureUI()
    }
    // MARK: - Helpers
    private func configureTableView() {
        studyGroupTableView.dataSource = self
        studyGroupTableView.delegate = self
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(studyGroupTableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(183)
            make.height.equalTo(24)
        }
        
        studyGroupTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(20) // necessary?
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    
}

extension GroupListViewController: UITableViewDelegate {
    
}

extension GroupListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchGroupTableViewCell.identifier, for: indexPath) as? SearchGroupTableViewCell else { return UITableViewCell() }
        
        cell.configure(title: "temp title", date: "temp date", imageURL: "temp url", isCamOn: true)
        
        return cell
    }
    
    
}
