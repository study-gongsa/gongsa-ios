//
//  FilterViewController.swift
//  GongSa
//
//  Created by taechan on 2022/09/26.
//

import UIKit
import SnapKit

let ALPHA = 0.7

// 'weak' must not be applied to non-class-bound 'any FilterOptionDelegate'; consider adding a protocol conformance that has a class bound
// FilterOptionDelegate -> FilterOptionDelegate: AnyObject ===> solved
protocol FilterOptionDelegate: AnyObject {
    func didEnterOptions(camera: Int, selectedCategoryIndexes: [Int], term: Int)
}

final class FilterViewController: BasePopupViewController {

    // MARK: - Properties
    weak var delegate: FilterOptionDelegate?
    
    private var dummyCategoryIndexes: [Int] = [1,2,3,4,5,6,7]
    public var selectedCategoriesIndexes: [Int] = []

    private let filterView: UIView = {
        let view = UIView()
        return view
    }()

    private let cameraOptionLabel: UILabel = {
        let label = UILabel()
        label.text = "카메라 여부"
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()
    
    private let radioButton1: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    private let radioButton2: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    private let radioButton3: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cameraOption1: UIView = {
        let view = Utilities().buttonWithLabel(withButton: radioButton1, labelText: "모두보기")
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(radioButtonTapped))
//        view.addGestureRecognizer(tapRecognizer)
        return view
    }()
    
    private lazy var cameraOption2: UIView = {
        let radioButton = UIButton.radio()
        let view = Utilities().buttonWithLabel(withButton: radioButton2, labelText: "캠 켜기")
        return view
    }()
    private lazy var cameraOption3: UIView = {
        let radioButton = UIButton.radio()
        let view = Utilities().buttonWithLabel(withButton: radioButton3, labelText: "캠 끄기")
        return view
    }()

    private let categoryOptionLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리 (복수선택 가능)"
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()
    private let wrapperViewForCollectionView: UIView = {
        let view = UIView()
        return view
    }()
    private var categoryCollectionView: UICollectionView! // anti-pattern?

    private let termOptionLabel: UILabel = {
        let label = UILabel()
        label.text = "기간 (선택)"
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()
    private let termRadioButton1: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    private let termRadioButton2: UIButton = {
        let button = UIButton.radio()
        button.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var termOptionRecent: UIView = {
        let view = Utilities().buttonWithLabel(withButton: termRadioButton1, labelText: "최신순")
        return view
    }()
    private lazy var termOptionOld: UIView = {
        let radioButton = UIButton.radio()
        let view = Utilities().buttonWithLabel(withButton: termRadioButton2, labelText: "마감순")
        return view
    }()
    private let termHelpLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘을 기준으로 마감일이 가까운 스터디가 노출됩니다."
        label.font = .pretendard(size: 12, family: .medium)
        label.textColor = .gsDarkGray
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(ALPHA)
        
        configureCollectionView()
        configureUI()

        addTapRecognizer()
    }

    // MARK: - Helpers
    private func configureCollectionView() {
//        self.categoryCollectionView = UICollectionView(frame: self.wrapperViewForCollectionView.frame,
//                                                       collectionViewLayout: UICollectionViewFlowLayout())
//      위 방식 + protocol 방식으로는 셀 width, height 적용 안 되서 아래 방식으로 바꿨음
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // this is for direction
        layout.minimumInteritemSpacing = 12 // this is for spacing between cells
        layout.itemSize = CGSize(width: 45, height: 35) // this is for cell size
        self.categoryCollectionView = UICollectionView(frame: self.wrapperViewForCollectionView.frame,
                                                  collectionViewLayout: layout)

        self.categoryCollectionView.register(ChipCollectionViewCell.self,
                                             forCellWithReuseIdentifier: ChipCollectionViewCell.identifier)
        
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.allowsMultipleSelection = true
    }

    private func configureUI() {
        self.titleLabel.text = "스터디룸 필터"
        
        self.bottomButton.setTitle("저장", for: .normal)
        self.bottomButton.titleLabel?.font = .pretendard(size: 16, family: .bold)
        self.bottomButton.backgroundColor = .gsGreen
        self.bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)

        filterView.backgroundColor = .white
        self.view.addSubview(filterView)

        filterView.snp.makeConstraints { make in
            make.width.equalTo(363)
            make.height.equalTo(435)
            make.centerY.centerX.equalToSuperview()
        }
        filterView.layer.cornerRadius = 14 / 2
        filterView.clipsToBounds = true

        let cameraStackView = UIStackView(arrangedSubviews: [cameraOption1,
                                                             cameraOption2,
                                                             cameraOption3])
        let termStackView = UIStackView(arrangedSubviews: [termOptionRecent,
                                                           termOptionOld])

        cameraStackView.axis = .horizontal
        cameraStackView.distribution = .equalSpacing
        termStackView.axis = .horizontal
        termStackView.distribution = .equalSpacing

        wrapperViewForCollectionView.addSubview(categoryCollectionView)

        filterView.addSubview(titleLabel)
        filterView.addSubview(cameraOptionLabel)
        filterView.addSubview(cameraStackView)
        filterView.addSubview(categoryOptionLabel)
        filterView.addSubview(wrapperViewForCollectionView)
        filterView.addSubview(termOptionLabel)
        filterView.addSubview(termStackView)
        filterView.addSubview(termHelpLabel)
        filterView.addSubview(bottomButton)

        // 스터디룸 필터 타이틀
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(28)
        }
        // 카메라 레이블
        cameraOptionLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).inset(-24)
        }
        // 버튼 3개
        cameraStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(cameraOptionLabel.snp.bottom).inset(-8)
        }
        // 카테고리 레이블
        categoryOptionLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(cameraStackView.snp.bottom).inset(-24)
        }
        wrapperViewForCollectionView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(categoryOptionLabel.snp.bottom)
        }
        // 컬렉션 뷰
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.left.right.equalToSuperview()
        }
        // 기간
        termOptionLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(wrapperViewForCollectionView.snp.bottom).inset(-24)
        }
        // 버튼 2개
        termStackView.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(termOptionLabel.snp.bottom).inset(-8)
        }
        termOptionOld.snp.makeConstraints { make in
            make.left.equalTo(termOptionRecent.snp.right).inset(-15)
        }
        // 헬프 레이블
        termHelpLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(termStackView.snp.bottom).inset(-9)
        }
        bottomButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(termStackView.snp.bottom).inset(-50)
            make.bottom.equalToSuperview()
        }
    }

    private func addTapRecognizer() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false /// didSelectItemAt 함수 호출 안 되던 것 해결
        self.view.addGestureRecognizer(tap)
    }

    // MARK: - Selectors
    @objc func handleTap(tap: UITapGestureRecognizer) {
        if tap.state == UIGestureRecognizer.State.ended {
            /// dismiss if the point at which user tapped is inside codeInputView
            let point = tap.location(in: self.view)
            if !CGRectContainsPoint(self.filterView.frame, point) {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func whichCameraButtonOn() -> Int {
        if self.radioButton1.isSelected {
            return 0
        } else if self.radioButton2.isSelected {
            return 1
        } else if self.radioButton3.isSelected {
            return 2
        } else {
            return -1
        }
    }
    
    private func whichTermButtonOn() -> Int {
        if self.termRadioButton1.isSelected {
            return 0
        } else if self.termRadioButton2.isSelected {
            return 1
        } else {
            return -1
        }
    }
    
    @objc func bottomButtonTapped(_ sender: UIButton) {
        
        // pass filter option data back to parent VC
        self.selectedCategoriesIndexes = self.selectedCategoriesIndexes.map { $0 } /// indexPath.row: 0 based, categ: 1 based
        delegate?.didEnterOptions(camera: whichCameraButtonOn(),
                                  selectedCategoryIndexes: self.selectedCategoriesIndexes,
                                  term: whichTermButtonOn())
        
        self.dismiss(animated: true)
    }
    
    @objc private func radioButtonTapped(_ sender: UIButton) {
        setCameraOption(selectedButton: sender)
    }
    
    private func setCameraOption(selectedButton: UIButton) {
        let cameraButtons = [self.radioButton1, self.radioButton2, self.radioButton3]
        let termButtons = [self.termRadioButton1, self.termRadioButton2]
        let targetButtons = cameraButtons.contains(selectedButton) ? cameraButtons : termButtons
        
        let filteredSetButtons = targetButtons.filter { $0 != selectedButton }
        for button in filteredSetButtons {
            setRadioButton(button: button, selected: false)
        }
        setRadioButton(button: selectedButton, selected: true)
    }
    
    private func setRadioButton(button: UIButton, selected: Bool) {
        button.isSelected = selected
        if selected {
            button.setImage(UIImage(named: "toggleOn"), for: .normal)
        } else {
            button.setImage(UIImage(named: "toggleOff"), for: .normal)
        }
    }
}

extension FilterViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dummyCategoryIndexes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.identifier, for: indexPath) as? ChipCollectionViewCell else { return UICollectionViewCell() }

        // configure cell
        let index = self.dummyCategoryIndexes[indexPath.row]
        cell.title = idxToCategory[index]
        
        // 이미 선택했었던 카테고리들 초록색으로 pre-populate
        let oneBasedIndex = indexPath.row+1
        if self.selectedCategoriesIndexes.contains(oneBasedIndex) {
            cell.selectTitleLabel()
        }

        return cell
    }
}

extension FilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = self.categoryCollectionView.cellForItem(at: indexPath) as? ChipCollectionViewCell else { return }
        
        let oneBasedIndex = indexPath.row+1
        if selectedCategoriesIndexes.contains(oneBasedIndex) {
            selectedCategoriesIndexes = selectedCategoriesIndexes.filter { $0 != oneBasedIndex }
            cell.unselectTitleLabel()
        } else {
            selectedCategoriesIndexes.append(oneBasedIndex)
            cell.selectTitleLabel()
        }
        self.categoryCollectionView.deselectItem(at: indexPath, animated: true)
    }
}
