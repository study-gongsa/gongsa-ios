//
//  StudyRoomViewController.swift
//  GongSa
//
//  Created by Chaerin Han on 2022/10/16.
//

import UIKit
import SwiftUI
import SnapKit
import Then

class StudyRoomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.navigationItem.title = "비밀번호 찾기"
    
        self.configure()
        self.setUpView()
        self.setConstaints()
    
    }
    
    // MARK: - Properties
    
    /// Expandable Button
    var mainStackWidthConstraint:NSLayoutConstraint!
    private var widthConstant:CGFloat = 72 {
           didSet {
                self.mainStackWidthConstraint.constant = widthConstant
                self.pinBackground(self.backgroundView, to: self.mainStackView)
           }
       }
       
       private var buttonsAreHidden = true {
           didSet {
               performAnimation()
           }
       }
       
       private var updateButtonImage = false {
           didSet {
               self.priceButton.setImage(UIImage(systemName: updateButtonImage ? "playpause.fill" : "playpause"), for: UIControl.State.normal)
               
           }
       }
    
    // MARK: - Configure
    
    func configure () {
        self.memberCollecionView.delegate = self
        self.memberCollecionView.dataSource = self
        self.memberCollecionView.register(Studyroom_StudyingMembersCollectionViewCell.self, forCellWithReuseIdentifier: Studyroom_StudyingMembersCollectionViewCell.identifier)
        //main stack will have price button & stack view
        configureMainStackView()
        
        //add buttons to stack view
        configureButtonsStack()
        
        //hide the stack view initially
        buttonStackView.isHidden = true
        
        //set backgroundView to hold stackviews
        pinBackground(backgroundView, to: mainStackView)
    }
    
    // MARK: - Event

    @objc func expandButton(_ sender: UIButton) {
        buttonsAreHidden.toggle()
    }
    
    @objc func tapFunctionBtn(_ sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case 0:
            // Out the Studyroom
            print("out the studyroom")
//            self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        case 1:
            // Make a question
            print("question")
            self.navigationController?.pushViewController(Studyroom_QAViewController(), animated: true)
            
        case 2:
            // Turn Off Camera
            print("camera")
            
        default:
            print("expandableButton - Function Button ERROR")
        }
    }
    
    
    // MARK: - UI
    // 이미지뷰 담을 뷰
    lazy var myCameraContentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    // 프로필 이미지 뷰
    lazy var myCameraView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "testImg")
        img.backgroundColor = .white
        img.contentMode = .scaleAspectFill
        return img
        
    }()
    
    var memberCollecionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
//    var memberCollecionView = UICollectionView().then {
//        let flowLayout = UICollectionViewFlowLayout.self
//        $0.register(Studyroom_StudyingMembersCollectionViewCell.self, forCellWithReuseIdentifier: Studyroom_StudyingMembersCollectionViewCell.identifier)
//    }
    
    // Expandable Button
    private let buttonTitles = ["icon-out-mono", "question.bubble", "cameraOff"]
    
    lazy var backgroundView = UIView().then {
//        $0.layer.cornerRadius = 1
        $0.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
    }
    
    lazy var mainStackView  = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.layer.borderWidth = 0
    }
    
    lazy var buttonStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 2.0
        $0.distribution = .fillProportionally
        $0.layer.borderWidth = 0
    }
    // expandableButton
    lazy var priceButton = UIButton().then{
        
        $0.setImage(UIImage(systemName: "clock.arrow.circlepath"), for: UIControl.State.normal)
        //        UIImage(systemName: "search", withConfiguration: boldConfig)
        //        $0.semanticContentAttribute = .forceLeftToRight
        $0.semanticContentAttribute = .forceRightToLeft
//        $0.setTitle("", for: UIControl.State.normal)
//        $0.setTitleColor(UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1), for: UIControl.State.normal)
        $0.tintColor = UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1)
        $0.addTarget(self, action: #selector(expandButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    
    
    
    // MARK: - Set View
    func setUpView() {
        self.view.addSubview(self.myCameraContentView)
        self.myCameraContentView.addSubview(self.myCameraView)
        self.view.addSubview(self.memberCollecionView) // 로그인
        
    }
    
    //MARK: - UI Constraints
    
    func setConstaints() {
        // ImageView 담을 View
        self.myCameraContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(375)
            $0.height.equalTo(335)
            
        }
        // 상단 내 화면 ImageView
        self.myCameraView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//         아래 하단 멤버 Collection View
        self.memberCollecionView.snp.makeConstraints {
            $0.top.equalTo(myCameraContentView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
            
//            $0.top.equalTo(profileImgView.snp.bottom).offset(60)
//            $0.trailing.leading.equalToSuperview().inset(24)
//            $0.bottom.equalToSuperview()

        }

        
        
        
    }
}

// MARK: CollectionView Extension
extension StudyRoomViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO:  나중에 api 연결해서 하기
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Studyroom_StudyingMembersCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 12
        
        let myWidth : CGFloat = (collectionView.bounds.width - itemSpacing * 2) / 3
        
        
        return CGSize(width: myWidth, height: myWidth)
    }
}


// MARK: stack views configuration
extension StudyRoomViewController {
    
    private func configureMainStackView() {
        self.view.addSubview(mainStackView)

//        [priceButton, buttonStackView].forEach { (view) in
//            self.mainStackView.addArrangedSubview(view)
//        }

        [buttonStackView, priceButton].forEach { (view) in
            self.mainStackView.addArrangedSubview(view)
        }
        /// set constraints
        
        mainStackWidthConstraint = self.mainStackView.widthAnchor.constraint(equalToConstant: widthConstant)

        self.mainStackView.snp.makeConstraints {
//            $0.width.equalTo(widthConstant)
//            $0.top.equalTo(memberCollecionView.snp.bottom).inset(40)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-104)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(48)
//            mainStackWidthConstraint
        }

        NSLayoutConstraint.activate([
//            self.mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 24),
            mainStackWidthConstraint,
            self.mainStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    
    private func configureButtonsStack() {
        buttonTitles.enumerated().forEach { index, value in
            let functionBtn = UIButton(type: .system)
//            dollar.setTitle(value, for: UIControl.State.normal)
//            functionBtn.addLeftBorder()
            functionBtn.tag = index
            functionBtn.addTarget(self, action: #selector(tapFunctionBtn(_ :)), for: UIControl.Event.touchUpInside)
            
            functionBtn.setImage(UIImage(named: value), for: UIControl.State.normal)
            functionBtn.tintColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1)
//            functionBtn.setTitleColor(UIColor(red: 0.176, green: 0.71, blue: 0.482, alpha: 1), for: UIControl.State.normal)
            buttonStackView.addArrangedSubview(functionBtn)
        }
    }
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
    

}

// MARK : animation
extension StudyRoomViewController {
    
    fileprivate func performAnimation() {
        let screenSize = UIScreen.main.bounds
        
        let stackedButtons = self.buttonStackView.arrangedSubviews
        
        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            
            //hide or show the stackview.
            self.buttonStackView.isHidden = self.buttonsAreHidden
            
            /// change button image and update the width constraint
            self.updateButtonImage = !self.buttonsAreHidden
            self.widthConstant = self.buttonsAreHidden ?  self.priceButton.frame.width : 216
//            self.widthConstant = self.buttonsAreHidden ?  self.priceButton.frame.width : screenSize.size.width - 20

            
            //handle left borders while animating.
            stackedButtons.forEach({ (button) in
                button.layer.sublayers?.first?.isHidden = self.buttonsAreHidden
            })
            
            //remove all existing constraints
            self.backgroundView.constraints.forEach({ (constraint) in
                constraint.isActive = false
            })
            
            self.view.layoutIfNeeded()
        }
        animation.startAnimation()
    }
}
