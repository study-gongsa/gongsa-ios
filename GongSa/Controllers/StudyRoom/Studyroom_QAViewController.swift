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
@available(iOS 13.0, *)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Q&A"
        
        self.configure()
        self.setView()
        self.setConstraints()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.titleTxtView.resignFirstResponder()
        self.contentTxtView.resignFirstResponder()
    }
    
    
    // MARK: - Configure
    func configure() {
        self.titleTxtView.delegate = self
        self.contentTxtView.delegate = self
    }
    
    
    // MARK: - UI
    
    // 제목 TextView
    lazy var titleTxtView = UITextView().then {
        
        $0.layer.borderWidth = 1
        $0.backgroundColor = .white
        $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1).cgColor
        
        // place holder
        $0.text = "질문 제목"
        $0.textColor = UIColor.lightGray
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
        view.addSubview(self.titleTxtView)
        view.addSubview(self.contentTxtView)
        view.addSubview(self.okBtn)
    }
    
    
    
    
        
    // MARK: - Constraints
    
    
    func setConstraints() {
        
        self.titleTxtView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(52)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.height.equalTo(43)
        }
        
        self.okBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        
        self.contentTxtView.snp.makeConstraints {
            $0.top.equalTo(titleTxtView.snp.bottom).offset(20)
            $0.trailing.leading.equalToSuperview().inset(24)
            $0.bottom.equalTo(okBtn.snp.topMargin).offset(-40)
        }
        
        
        
    }
    
    
    
    
    
    
}

extension Studyroom_QAViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.isEmpty {
               textView.text =  "플레이스홀더입니다"
               textView.textColor = UIColor.lightGray
           }

       }

       
       func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.textColor == UIColor.lightGray {
               textView.text = nil
               textView.textColor = UIColor.black
           }
       }
}
