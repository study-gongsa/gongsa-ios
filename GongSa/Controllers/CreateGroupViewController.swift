//
//  CreateGroupViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit
import SnapKit
import BetterSegmentedControl
import Photos
import PhotosUI

/// TODO
/// 1. penalty, study re-entry textfield validation check

class CreateGroupViewController: UIViewController {
    
    // MARK: - Properties
    var items: [String] = ["자격증", "어학", "취업", "시험", "공무원", "독서", "기타"]
    var selectedCategoriesIndexes: [Int] = []
    private var categoryCollectionView: UICollectionView!
    
    private lazy var penaltyTextField: UITextField = {
        let tf = UITextField.gray(with: "최대 10점까지 가능합니다.")
        tf.isEnabled = false
        return tf
    }()
    private lazy var reEntryTextField: UITextField = {
        let tf = UITextField.gray(with: "최대 7번까지 가능합니다.")
        tf.isEnabled = false
        return tf
    }()
    
    let picker = UIImagePickerController()
    
    private let titleLabel: UILabel = {
        return UILabel.customLabel(with: "스터디그룹 생성하기", color: .gsBlack, fontSize: 20, fontFamily: .bold)
    }()
    
    private var groupTitleTextField: UITextField = {
        let textField = Utilities().textField(withPlaceholder: "제목을 입력하세요")
        textField.addTarget(self, action: #selector(groupTitleTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var groupContainerView: UIView = {
        let view = Utilities().inputContainerView(text: "방 제목", textField: groupTitleTextField)
        return view
    }()
    
    private let cameraTitleLabel: UILabel = {
        return UILabel.customLabel(with: "카메라", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let camOnButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var camOnView: UIView = {
        return Utilities().buttonWithLabel(withButton: camOnButton, labelText: "캠 켜기")
    }()
    
    private let camOffButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var camOffView: UIView = {
        return Utilities().buttonWithLabel(withButton: camOffButton, labelText: "캠 끄기")
    }()
    
    private let chatOnButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var chatOnView: UIView = {
        return Utilities().buttonWithLabel(withButton: chatOnButton, labelText: "채팅 허용")
    }()
    
    private let chatOffButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var chatOffView: UIView = {
        return Utilities().buttonWithLabel(withButton: chatOffButton, labelText: "채팅 비허용")
    }()
    
    private let chatTitleLabel: UILabel = {
        return UILabel.customLabel(with: "채팅", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let limitTitleLabel: UILabel = {
        return UILabel.customLabel(with: "제한 인원", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private lazy var limitButtons: UIView = {
        let view = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 380.0, width: 150, height: 30.0),
            segments: LabelSegment.segments(withTitles: ["1", "2", "3", "4", "5", "6"],
                                            normalTextColor: .black,
                                            selectedTextColor: .white),
            options: [.cornerRadius(7.5),
                      .backgroundColor(.white),
                      .indicatorViewBackgroundColor(.gsGreen),])
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gsLightGray.cgColor
        view.addTarget(self, action: #selector(limitButtonTapped), for: .valueChanged)
        return view
    }()
    
    private let publicTitleLabel: UILabel = {
        return UILabel.customLabel(with: "공개여부", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let publicOnButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var publicOnView: UIView = {
        return Utilities().buttonWithLabel(withButton: publicOnButton, labelText: "공개")
    }()
    
    private let publicOffButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var publicOffView: UIView = {
        return Utilities().buttonWithLabel(withButton: publicOffButton, labelText: "비공개")
    }()
    
    private let categoryTitleLabel: UILabel = {
        return UILabel.customLabel(with: "카테고리 선택(복수 선택 가능)", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let penaltyTitleLabel: UILabel = {
        return UILabel.customLabel(with: "벌점", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let penaltyOnButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var penaltyOnView: UIView = {
        return Utilities().buttonWithLabel(withButton: penaltyOnButton, labelText: "없음")
    }()
    
    private let penaltyOffButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var penaltyOffView: UIView = {
        return Utilities().buttonWithLabel(withButton: penaltyOffButton, labelText: "있음")
    }()
    
    private let reEntryTitleLabel: UILabel = {
        return UILabel.customLabel(with: "스터디 재진입", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let reEntryOnButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var reentryOnView: UIView = {
        return Utilities().buttonWithLabel(withButton: reEntryOnButton, labelText: "불가")
    }()
    
    private let reEntryOffButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var reentryOffView: UIView = {
        return Utilities().buttonWithLabel(withButton: reEntryOffButton, labelText: "허용")
    }()
    
    private let targetTimeTitleLabel: UILabel = {
        return UILabel.customLabel(with: "스터디 목표 시간", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let backgroundImageTitleLabel: UILabel = {
        return UILabel.customLabel(with: "배경 이미지", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private let backgroundImageOnButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundImageOnView: UIView = {
        return Utilities().buttonWithLabel(withButton: backgroundImageOnButton, labelText: "사용안함")
    }()
    
    private let backgroundImageOffButton: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundImageOffView: UIView = {
        return Utilities().buttonWithLabel(withButton: backgroundImageOffButton, labelText: "사용함")
    }()
    
    private lazy var backgroundImageUploadButton: UIButton = {
        let button = UIButton.gray(with: "이미지 올리기")
        button.addTarget(self, action: #selector(imageUploadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let termTitleLabel: UILabel = {
        return UILabel.customLabel(with: "스터디 기간", color: .gsBlack, fontSize: 16, fontFamily: .bold)
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton.main(withTitle: "생성하기")
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var scrollView = UIScrollView()
    
    private lazy var targetTimePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = .current
        datePicker.minuteInterval = 30
        datePicker.addTarget(self, action: #selector(timePickerValueChanged),
                             for: .valueChanged)
        return datePicker
    }()
    
    private lazy var dateTimePicker1: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(datePickerValueChanged),
                             for: .valueChanged)
        return datePicker
    }()
    
    private lazy var dateTimePicker2: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(datePickerValueChanged),
                             for: .valueChanged)
        return datePicker
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureCollectionView()
        configureUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: view.frame.width, height: 1250)
    }
    
    // MARK: - Selectors
    @objc func imageUploadButtonTapped(_ sender: UIButton) {
        print("DEBUG - image upload tapped", sender)
        
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openPHPicker() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func createButtonTapped(_ sender: UIButton) {
        print("DEBUG - create button tapped", sender)
    }
    
    @objc func groupTitleTextFieldDidChange(_ sender: UITextField) {
        print("DEBUG - group text field text: ", sender)
    }
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        print("DEBUG - radio button tapped!", sender)
        let cameraButtons  = [self.camOnButton, self.camOffButton]
        let chatButtons    = [self.chatOnButton, self.chatOffButton]
        let publicButtons  = [self.publicOnButton, self.publicOffButton]
        let penaltyButtons = [self.penaltyOnButton, self.penaltyOffButton]
        let reEntryButtons = [self.reEntryOnButton, self.reEntryOffButton]
        let backgroundImageButtons = [self.backgroundImageOnButton, self.backgroundImageOffButton]
        
        var targetButtons: [UIButton]!
        if cameraButtons.contains(sender) {
            targetButtons = cameraButtons
        } else if chatButtons.contains(sender) {
            targetButtons = chatButtons
        } else if publicButtons.contains(sender) {
            targetButtons = publicButtons
        } else if penaltyButtons.contains(sender) {
            targetButtons = penaltyButtons
        } else if reEntryButtons.contains(sender) {
            targetButtons = reEntryButtons
        } else if backgroundImageButtons.contains(sender) {
            targetButtons = backgroundImageButtons
        }
        
        let filteredSetButtons = targetButtons.filter { $0 != sender }
        for button in filteredSetButtons {
            setRadioButton(button: button, selected: false)
        }
        setRadioButton(button: sender, selected: true)
    }
    
    @objc func limitButtonTapped(_ sender: BetterSegmentedControl) {
        print("DEBUG - BS tapped!", sender)
    }
    
    @objc func timePickerValueChanged(_ sender: UIDatePicker) {
        print("DEBUG - Selected value \(sender.countDownDuration)")
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        print("DEBUG - date picker value", sender, sender.date)
    }
    
    // MARK: - Helpers
    
    private func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    private func openCamera(){
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    private func setRadioButton(button: UIButton, selected: Bool) {
        button.isSelected = selected
        if selected {
            button.setImage(UIImage(named: "toggleOn"), for: .normal)
            // help text field showing
            if button == penaltyOnButton {
                self.penaltyTextField.isEnabled = false
            } else if button == reEntryOnButton {
                self.reEntryTextField.isEnabled = false
            }
        } else {
            button.setImage(UIImage(named: "toggleOff"), for: .normal)
            // help text field not showing
            if button == penaltyOnButton {
                self.penaltyTextField.isEnabled = true
                self.penaltyTextField.text = ""
            } else if button == reEntryOnButton {
                self.reEntryTextField.isEnabled = true
                self.reEntryTextField.text = ""
            }
        }
    }
    
    private func shouldCreateButtonOn() {
        if groupTitleTextField.text  == "" { disEnableCreateButton(); return }
        if camOnButton.isEnabled     == false && camOffButton.isEnabled     == false { disEnableCreateButton(); return }
        if chatOnButton.isEnabled    == false && chatOffButton.isEnabled    == false { disEnableCreateButton(); return }
        if publicOnButton.isEnabled  == false && publicOffButton.isEnabled  == false { disEnableCreateButton(); return }
        if penaltyOnButton.isEnabled == false && penaltyOffButton.isEnabled == false { disEnableCreateButton(); return }
        if reEntryOnButton.isEnabled == false && reEntryOffButton.isEnabled == false { disEnableCreateButton(); return }
        if backgroundImageOnButton.isEnabled == false && backgroundImageOffButton.isEnabled == false { disEnableCreateButton(); return }
        if selectedCategoriesIndexes.count == 0 { return }
        
        enableCreateButton()
    }
    
    private func enableCreateButton() {
        self.createButton.isEnabled = true
        self.createButton.backgroundColor = .gsGreen
    }
    
    private func disEnableCreateButton() {
        self.createButton.isEnabled = false
        self.createButton.backgroundColor = .gsLightGray
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 45, height: 35)
        categoryCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 50),
                                                  collectionViewLayout: layout)
        categoryCollectionView.register(StudCollectionViewCell.self,
                                        forCellWithReuseIdentifier: StudCollectionViewCell.identifier)
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate   = self
        categoryCollectionView.allowsMultipleSelection = true
    }
    
    //        scrollView.addSubview(targetTimeTitleLabel)
    //        // target time picker
    //        scrollView.addSubview(termTitleLabel)
    //        // term picker
    //        scrollView.addSubview(createButton)
    private func configureUI() {
        //
        let tildeLabel = UILabel()
        tildeLabel.text = "~"
        
        let cameraStackView  = UIStackView(arrangedSubviews: [camOnView, camOffView])
        let chatStackView    = UIStackView(arrangedSubviews: [chatOnView, chatOffView])
        let publicStackView  = UIStackView(arrangedSubviews: [publicOnView, publicOffView])
        let penaltyStackView = UIStackView(arrangedSubviews: [penaltyOnView, penaltyOffView, penaltyTextField])
        let reEntryStackView = UIStackView(arrangedSubviews: [reentryOnView, reentryOffView, reEntryTextField])
        let backgroundImageStackView = UIStackView(arrangedSubviews: [backgroundImageOnView, backgroundImageOffView, backgroundImageUploadButton])
        let dateTimePickerStackView = UIStackView(arrangedSubviews: [dateTimePicker1, tildeLabel, dateTimePicker2])
        
        for stackView in [cameraStackView, chatStackView,
                          publicStackView, penaltyStackView,
                          reEntryStackView, backgroundImageStackView,
                          dateTimePickerStackView] {
            stackView.distribution = .equalSpacing
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        for view in [titleLabel, groupContainerView, cameraTitleLabel,
                     cameraStackView, chatTitleLabel, chatStackView,
                     limitTitleLabel, limitButtons, publicTitleLabel,
                     publicStackView, categoryTitleLabel, penaltyTitleLabel,
                     penaltyStackView, reEntryTitleLabel, reEntryStackView,
                     targetTimeTitleLabel, targetTimePicker, backgroundImageTitleLabel,
                     backgroundImageStackView, termTitleLabel, createButton,
                     dateTimePickerStackView] {
            scrollView.addSubview(view)
        }
        
        scrollView.addSubview(categoryCollectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(64)
            make.width.equalTo(161)
            make.height.equalTo(24)
        }
        
        groupContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-20)
            make.left.equalTo(titleLabel.snp.left)
            make.width.equalTo(327)
            make.height.equalTo(70)
        }
        
        cameraTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(groupContainerView.snp.bottom).inset(-33)
        }
        cameraStackView.snp.makeConstraints { make in
            //            make.left.equalTo(titleLabel.snp.left)
            make.left.equalTo(scrollView.snp.left).inset(24)
            make.right.equalTo(scrollView.snp.right).inset(24)
            make.width.equalTo(140)
            make.top.equalTo(cameraTitleLabel.snp.bottom).inset(-9)
        }
        
        chatTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(cameraStackView.snp.bottom).inset(-33)
        }
        chatStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(chatTitleLabel.snp.bottom).inset(-9)
            make.width.equalTo(180)
        }
        
        limitTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(chatStackView.snp.bottom).inset(-33)
        }
        
        limitButtons.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(24)
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(limitTitleLabel.snp.bottom).inset(-9)
        }
        
        publicTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(limitButtons.snp.bottom).inset(-33)
        }
        publicStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(publicTitleLabel.snp.bottom).inset(-9)
            make.width.equalTo(140)
        }
        
        categoryTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(publicStackView.snp.bottom).inset(-33)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width).inset(24)
            make.left.equalToSuperview().inset(24)
            //            make.right.equalToSuperview().inset(24)
            make.height.equalTo(35)
            make.top.equalTo(categoryTitleLabel.snp.bottom).inset(-9)
        }
        
        penaltyTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(categoryCollectionView.snp.bottom).inset(-33)
        }
        penaltyStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(penaltyTitleLabel.snp.bottom).inset(-9)
            make.width.equalTo(250)
        }
        
        reEntryTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(penaltyStackView.snp.bottom).inset(-33)
        }
        reEntryStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(reEntryTitleLabel.snp.bottom).inset(-9)
            make.width.equalTo(250)
        }
        
        targetTimeTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(reEntryStackView.snp.bottom).inset(-33)
        }
        
        targetTimePicker.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(targetTimeTitleLabel.snp.bottom).inset(-9)
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        backgroundImageTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(targetTimePicker.snp.bottom).inset(-33)
        }
        backgroundImageStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(backgroundImageTitleLabel.snp.bottom).inset(-9)
            make.width.equalTo(250)
        }
        
        termTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(backgroundImageStackView.snp.bottom).inset(-33)
        }
        
        dateTimePickerStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(termTitleLabel.snp.bottom).inset(-9)
        }
        
        dateTimePicker1.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        tildeLabel.snp.makeConstraints { make in
            make.left.equalTo(dateTimePicker1.snp.right)
            make.top.bottom.equalToSuperview()
        }
        dateTimePicker2.snp.makeConstraints { make in
            make.left.equalTo(tildeLabel.snp.right)
            make.right.top.bottom.equalToSuperview()
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(dateTimePicker1.snp.bottom).inset(-33)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(52)
        }
    }
}

extension CreateGroupViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudCollectionViewCell.identifier, for: indexPath) as? StudCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        /// configure cell
        let text = self.items[indexPath.row]
        cell.configure(text: text)
        
        return cell
    }
}

extension CreateGroupViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = self.categoryCollectionView.cellForItem(at: indexPath) as? StudCollectionViewCell else { return }
        
        let index: Int = indexPath.row
        if selectedCategoriesIndexes.contains(index) {
            selectedCategoriesIndexes = selectedCategoriesIndexes.filter { $0 != index }
            cell.unselectTitleLabel()
        } else {
            selectedCategoriesIndexes.append(index)
            cell.selectTitleLabel()
        }
        
        print("DEBUG - cell selected at", index)
        
        self.categoryCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CreateGroupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 38, height: 25)
    }
}


extension CreateGroupViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                print("DEBUG - picker success!", image)
                DispatchQueue.main.async {
                    // self.profilePictureOutlet.image = image
                    // TODO: - Here you get UIImage
                }
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: "public.image") { [weak self] url, _ in
                    // TODO: - Here You Get The URL
                }
            }
        }
    }
    
    /// call this method for `PHPicker`
    func openPHPicker() {
        var PHPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        PHPickerConfig.selectionLimit = 1
        PHPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let phPickerVC = PHPickerViewController(configuration: PHPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
}
