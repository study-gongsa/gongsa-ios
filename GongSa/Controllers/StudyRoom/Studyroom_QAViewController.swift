//
//  Studyroom_QAViewController.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/11/11.
//

import UIKit
import SwiftUI
import SnapKit
import Then

// MARK: - Canvas
struct Studyroom_QAViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = Studyroom_QAViewController
    
    func makeUIViewController(context: Context) -> Studyroom_QAViewController {
        return Studyroom_QAViewController()
    }
    
    func updateUIViewController(_ uiViewController: Studyroom_QAViewController, context: Context) {
    }
    
}

@available(iOS 13.0.0, *)
struct Studyroom_QAViewPreview: PreviewProvider {
    static var previews: some View {
        Studyroom_QAViewControllerRepresentable()
    }
}

class Studyroom_QAViewController: UIViewController {
    
    // MARK: - Properties
    var q_title: String = ""
    var q_content: String = ""
    
    var titleStatus: Bool = false
    var contentsStatus: Bool = false
    var okbtnStatus: Bool = false
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Q&A"
        
        self.configure()
        self.setView()
        self.setConstraints()
        
        addActions()
        
        okBtn.isEnabled = okbtnStatus
        
        if okBtn.isEnabled == true {
            print("버튼 눌린다")
        } else {
            print("버튼 안눌려진다")
        }
        
    }
    
   
    
    
    // MARK: - Configure
    func configure() {
        self.contentTxtView.delegate = self
        self.navigationItem.backBarButtonItem?.tintColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    
    // MARK: - UI
    
    // 제목 TextView
    lazy var titleTxtField = UITextField().then {
        
        $0.layer.borderWidth = 1
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1).cgColor
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        // place holder
        $0.placeholder = "질문 제목"
        $0.textColor = UIColor.lightGray
//        $0.setPadding(left: 16, right: 0)
    }
    
    // 내용 TextView
    lazy var contentTxtView = UITextView().then {
        
        $0.layer.borderWidth = 1
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1).cgColor
        
        // place holder
        $0.text = "질문 내용"
        $0.textColor = UIColor.lightGray
    }
    
    // 확인 Button
    lazy var okBtn = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
    }
    
    
    // MARK: - View
    
    func setView() {
        view.addSubview(self.titleTxtField)
        view.addSubview(self.contentTxtView)
        view.addSubview(self.okBtn)
    }
    
    // MARK: - Constraints
    
    func setConstraints() {
        
        self.titleTxtField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(52)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.height.equalTo(43)
        }
        
        self.okBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        
        self.contentTxtView.snp.makeConstraints {
            $0.top.equalTo(titleTxtField.snp.bottom).offset(20)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.bottom.equalTo(okBtn.snp.topMargin).offset(-40)
        }
        
        
        
    }
    
    
    // MARK: - Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.titleTxtView.resignFirstResponder()
        self.contentTxtView.resignFirstResponder()
    }
    
    func addActions() {
        okBtn.addTarget(self, action: #selector(self.registerQuestion), for: .touchUpInside)
        
        titleTxtField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
//        titleTxtField.addAction(UIAction(handler: self.textHandler), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
//        guard let email = sender.text, !email.isEmpty else { return }
        guard let q_title = sender.text, !q_title.isEmpty else { return }
        self.q_title = q_title
        
        if self.q_title.isEmpty {
            titleStatus = false
            print("제목 입력중", titleStatus)
        } else {
            titleStatus = true
            print("제목 입력중", titleStatus)
        }
        
        if contentsStatus, titleStatus {
            okBtn.isEnabled = true
            okBtn.backgroundColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
            okbtnStatus = true
        }
    }
    
    // 확인 버튼 - 질문 post
    @objc func registerQuestion(sender: UIButton) {

        print(okbtnStatus)
        if okbtnStatus {
            postQuestion()
        } else {
            print("값 부족")
        }
        
    }
    
    // MARK: - Network
    func postQuestion() {
        StudyroomQuestionService.shared.postQuestion(title: self.q_title, content: self.q_content, groupID: 28) { result in
            switch result
            {
            case .success(let questionInfo):
                print("스터디룸 질문 통신 성공")
                // 유저 정보 조회 성공
                
                if let data = questionInfo as? QuestionDataClass {
                    print("문제 등록 성공")
                    print("questionUID",data.questionUID)
                    
                }
                
            case .requestErr(let msg):
                // 로그인 실패
                if let msg = msg as? String{
                    
                    print("질문하기 통신 에러", "\(msg)")
                    // 나중에 다시 팝업 창 뜨게 하기
                }
            case .loginErr(let location):
                if location is String {
                    // 로그인 페이지로
                    self.navigationController?.pushViewController(LoginViewController(), animated: true)
                }
            case .networkFail:
                print("network fail")
            default :
                print("DEFAULT ERROR")
            }
        }
    }
    
    
    
}


extension Studyroom_QAViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text =  "질문 내용"
            textView.textColor = UIColor.lightGray
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text.count - range.length + text.count
        let maxCount = 300
        if newLength > maxCount {
          return false
        }
        
        if self.q_content.isEmpty {
            contentsStatus = false
        } else {
            contentsStatus = true
            print("내용 트루")
        }
        
        if contentsStatus, titleStatus {
            okBtn.isEnabled = true
            okBtn.backgroundColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
            okbtnStatus = true
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        guard let q_content = textView.text, !q_content.isEmpty else { return }
        self.q_content = q_content
        
    }
    
}
