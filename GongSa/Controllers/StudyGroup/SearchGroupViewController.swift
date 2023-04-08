//
//  SearchViewController.swift
//  GongSa
//
//  Created by taechan on 2022/07/31.
//

import UIKit
import SnapKit
import BetterSegmentedControl
import Alamofire
import Kingfisher

let reuseIdentifier = "SearchGroupViewController"

let idxToCategory: [Int: String] = [1: "자격증", 2: "어학", 3: "취업", 4: "시험", 5: "공무원", 6: "독서", 7: "기타"]

final class SearchGroupViewController: UIViewController {
    
    // MARK: - Properties
    /// filter
    private var selectedCategoryIndexes: [Int] = []
    private var selectedCamera: Int = -1
    private var selectedLatest: Int = -1
    
    private var query: String = ""
    
    private var dummySearchGroup: [StudyGroup] = []
    private var dummyCameraOffSearchGroup: [StudyGroup] = []
    
    
    private var cameraToggleOn: Bool = false
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "궁금한게 있으신가요?"
        searchBar.searchTextField.font = .pretendard(size: 12, family: .bold)
        searchBar.searchTextField.backgroundColor = .gsWhite
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = UIColor.gsLightGray.cgColor
        searchBar.searchTextField.layer.cornerRadius = 28 / 2.0
        searchBar.searchTextField.clipsToBounds = true
        return searchBar
    }()
    
    private let wrapperViewForCollectionView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var categoryCollectionView: UICollectionView! // anti-pattern?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "이런 방은 어떠세요?"
        label.font = UIFont.pretendard(size: 20, family: .bold)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchGroupTableViewCell.self, forCellReuseIdentifier: SearchGroupTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var toggleView: UIView = {
        let view = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 380.0, width: 160, height: 30.0),
            segments: IconSegment.segments(withIcons: [UIImage(named: "cameraOff")!, UIImage(named: "cameraOn")!],
                                           iconSize: CGSize(width: 20.0, height: 20.0),
                                           normalIconTintColor: .gsLightGray,
                                           selectedIconTintColor: .gsWhite),
            options: [.cornerRadius(15.0),
                      .backgroundColor(.white),
                      .indicatorViewBackgroundColor(.gsGreen),])
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.gsGreen.cgColor
        view.addTarget(self, action: #selector(toggleTapped), for: .valueChanged)
        return view
    }()
    
    private var toggleSelected: Bool = false
    
    private var imageLoader: ImageCacheLoader = ImageCacheLoader()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureSearchBar()
        
        searchBar.delegate = self
        
        configureCollectionView()
        configureTableView()
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        self.tableView.backgroundView = bgView
        
        fetchRecommendedData()
    }
    
    private func fetchRecommendedData() {
        let params = ["type": "main"]
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJmcmVzaCIsImlhdCI6MTY2NjQ5ODMzOSwiZXhwIjoxNjY5MDkwMzM5LCJ1c2VyVUlEIjo0MCwidXNlckF1dGhVSUQiOjIxMn0.UAKj98uoKNwVudndMKmSa4X1wTBqFWUqZUaGak0qaKA"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        APIService.shared.recommend(params: params, headers: headers) { response in
            guard let searchGroupList = response.value?.data?.studyGroupList else { return }
            self.dummySearchGroup = searchGroupList.filter { $0.isCam == true }
            self.dummyCameraOffSearchGroup = searchGroupList.filter { $0.isCam == false }
            
            self.tableView.reloadData()
            print("debug - off", self.dummyCameraOffSearchGroup)
        }
    }
    
    // MARK: - Selectors
    @objc func toggleTapped(_ sender: BetterSegmentedControl) {
        /// sender.index: either 0 or 1
        let cameraOn = 1
        if sender.index == cameraOn {
            cameraToggleOn = true
        } else {
            cameraToggleOn = false
        }
        print("DEBUG - toggle", sender.index, cameraToggleOn)
        self.tableView.reloadData()
    }
    
    @objc func enterCodeButtonTapped() {
        pushPopUpViewController(EnterCodeViewController())
    }
    
    @objc func filterButtonTapped() {
        let filterVC = FilterViewController()
        /// pre-populate selected categories
        filterVC.selectedCategoriesIndexes = selectedCategoryIndexes
        filterVC.delegate = self
        pushPopUpViewController(filterVC)
    }
    
    // MARK: - Helpers
    private func pushPopUpViewController(_ viewController: UIViewController) {
        let vc = viewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    private func configureSearchBar() {
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        let enterCodeButton = UIBarButtonItem(title: "입장코드",
                                              style: .done,
                                              target: self,
                                              action: #selector(enterCodeButtonTapped))
        enterCodeButton.tintColor = .gsLightGray
        
        let filterButton = UIBarButtonItem(title: "filter",
                                           style: .plain,
                                           target: self,
                                           action: #selector(filterButtonTapped))
        filterButton.image = UIImage(named: "filter")
        filterButton.tintColor = .gsLightGray
        
        navigationItem.setRightBarButtonItems([filterButton, enterCodeButton], animated: true)
    }
    
    private func configureCollectionView() {
        view.addSubview(wrapperViewForCollectionView)
        
        wrapperViewForCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(24)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(38)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // this is for direction
        layout.minimumInteritemSpacing = 12 // this is for spacing between cells
        layout.itemSize = CGSize(width: 45, height: 35) // this is for cell size
        categoryCollectionView = UICollectionView(frame: self.wrapperViewForCollectionView.frame,
                                                  collectionViewLayout: layout)
        categoryCollectionView.dataSource = self
        
        categoryCollectionView.register(ChipCollectionViewCell.self,
                                        forCellWithReuseIdentifier: ChipCollectionViewCell.identifier)
        
        wrapperViewForCollectionView.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(wrapperViewForCollectionView.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
    }
    
    private func createTableHeaderView() -> UIView {
        print("DEBUG - header")
        let headerStackView = UIStackView()
        view.addSubview(headerStackView)
        headerStackView.snp.makeConstraints { make in
            make.top.equalTo(wrapperViewForCollectionView.snp.bottom).inset(-30)
            make.left.right.equalToSuperview().inset(24)
        }
        
        headerStackView.addSubview(headerLabel)
        headerStackView.addSubview(self.toggleView)
        
        headerStackView.axis = .horizontal
        
        headerLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        self.toggleView.snp.makeConstraints { make in
            make.left.equalTo(headerLabel.snp.right)
            make.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        return headerStackView
    }
}

// MARK: - UITableView Delegate
extension SearchGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("DEBUG - clicked:", self.dummySearchGroup[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableView Datasource

extension SearchGroupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG - updated2", cameraToggleOn, self.dummySearchGroup.count, self.dummyCameraOffSearchGroup.count)
        if cameraToggleOn {
            return self.dummySearchGroup.count
        } else {
            return self.dummyCameraOffSearchGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchGroupTableViewCell.identifier, for: indexPath) as? SearchGroupTableViewCell else {
            return UITableViewCell()
        }
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        let searchGroup: StudyGroup
        
        if self.cameraToggleOn {
            // cell with camera on
            searchGroup = self.dummySearchGroup[indexPath.row]
        } else {
            // cell with camera off
            searchGroup = self.dummyCameraOffSearchGroup[indexPath.row]
        }
        
        guard let url = URL(string: AuthService.Constants.baseURL + "api/image/" + searchGroup.imgPath) else { print("debug - error"); fatalError("invalid url") }
        let modifier = AnyModifier { request in
            var req = request
            req.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJmcmVzaCIsImlhdCI6MTY2NjUxODc4NiwiZXhwIjoxNjY5MTEwNzg2LCJ1c2VyVUlEIjo0MCwidXNlckF1dGhVSUQiOjIyNn0.IPZGj1GCTwrHkyMNPI3qP3H63chztwPn_LwuAlE4nEg", forHTTPHeaderField: "Authorization")
            return req
        }
        DispatchQueue.main.async {
            cell.configure(title: searchGroup.name,
                           date: String(searchGroup.createdAt),
                           imageURL: searchGroup.imgPath,
                           isCamOn: searchGroup.isCam)
            cell.delegate  = self
            cell.indexPath = indexPath
            cell.groupImageView.kf.setImage(with: url, placeholder: UIImage(named: "img3"), options: [.requestModifier(modifier), ])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerStackView = self.createTableHeaderView()
        return headerStackView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

// MARK: - UICollectionView Datasource
extension SearchGroupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedCategoryIndexes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipCollectionViewCell.identifier, for: indexPath) as? ChipCollectionViewCell else { return UICollectionViewCell() }
        
        // configure cell
        let index = self.selectedCategoryIndexes[indexPath.row]
        cell.title = idxToCategory[index]
        
        return cell
    }
}

extension SearchGroupViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.query = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        print("Search button clicked!", searchBar.text)
        
        /// fetch study-group List by query
        /// input: query - study-group name (OR study-group code)
        /// output: study-group list
        /// * output should be inside viewModel.
        /// align=latest&categoryUIDs=1&categoryUIDs=2&isCam=true
        var camera: Bool?
        if self.selectedCamera == 1 {
            camera = true
        } else if self.selectedCamera == 2 {
            camera = false
        }
        
        let latest: String = self.selectedLatest == 0 ? "latest" : "expire"
        var params: [String: Any] = ["align": latest,
                                     "categoryUIDs": self.selectedCategoryIndexes,
                                     "isCam": camera ?? "temp",
                                     "word": self.query
        ]
        if camera == nil {
            params.removeValue(forKey: "isCam")
        }
        
        let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJmcmVzaCIsImlhdCI6MTY2NjQ5ODMzOSwiZXhwIjoxNjY5MDkwMzM5LCJ1c2VyVUlEIjo0MCwidXNlckF1dGhVSUQiOjIxMn0.UAKj98uoKNwVudndMKmSa4X1wTBqFWUqZUaGak0qaKA"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        APIService.shared.search(params: params, headers: headers) { response in
            
            print("DEBUG - search result", response)
            
            guard let searchGroupList = response.value?.data?.studyGroupList else { return }
            self.dummySearchGroup = searchGroupList.filter { $0.isCam == true }
            self.dummyCameraOffSearchGroup = searchGroupList.filter { $0.isCam == false }
            
            DispatchQueue.main.async {
                print("DEBUG - updated", self.dummySearchGroup)
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchGroupViewController: FilterOptionDelegate {
    func didEnterOptions(camera: Int, selectedCategoryIndexes: [Int], term: Int) {
        print("DEBUG - camera data: ", camera)
        print("DEBUG - category data: ", selectedCategoryIndexes)
        print("DEBUG - term data: ", term)
        
        self.selectedCamera = camera
        self.selectedCategoryIndexes = selectedCategoryIndexes
        self.selectedLatest = term
        
        self.categoryCollectionView.reloadData()
    }
}

extension SearchGroupViewController: infoTapDelegate {
    func infoButtonTapped(indexPath: IndexPath) {
        let searchGroup: StudyGroup
        if cameraToggleOn {
            searchGroup = self.dummySearchGroup[indexPath.row]
        } else {
            searchGroup = self.dummyCameraOffSearchGroup[indexPath.row]
        }
        
        let enterStudyGroupVC = EnterStudyGroupViewController()
        /// pre-populate selected categories
        enterStudyGroupVC.configure(searchGroup: searchGroup)
        pushPopUpViewController(enterStudyGroupVC)
    }
}




typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class ImageCacheLoader {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    public func obtainImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            /* You need placeholder image in your assets,
             if you want to display a placeholder to user */
            let placeholder = #imageLiteral(resourceName: "toggleOn")
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url: URL! = URL(string: imagePath)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in
                if let data = try? Data(contentsOf: url) {
                    let img: UIImage = UIImage(data: data) ?? placeholder
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(img)
                    }
                }
            })
            task.resume()
        }
    }
}
