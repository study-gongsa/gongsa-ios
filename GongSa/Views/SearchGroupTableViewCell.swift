//
//  SearchGroupTableViewCEll.swift
//  GongSa
//
//  Created by taechan on 2022/09/23.
//

import UIKit
import SnapKit
import SDWebImage
import Kingfisher

protocol infoTapDelegate: AnyObject {
    func infoButtonTapped(indexPath: IndexPath)
}

final class SearchGroupTableViewCell: UITableViewCell {
    static let identifier = "SearchGroupTableViewCell"
    
    weak var delegate: infoTapDelegate?
    
    public var indexPath: IndexPath?
    
    // MARK: - Properties
    public let groupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera")
        return imageView
    }()
    
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .pretendard(size: 16, family: .bold)
        return label
    }()
    
    private let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .pretendard(size: 12, family: .medium)
        return label
    }()
    
    private let cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cameraOn")?.withTintColor(.gsDarkGray), for: .normal)
        return button
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "info")?.withTintColor(.gsDarkGray), for: .normal)
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Search Group table view cell - init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        
        /// remove outer separator line
        for view in subviews where view != contentView {
            view.removeFromSuperview()
        }
    }
    
    // MARK: - Helpers
    private func configureUI() {
        
        //        backgroundColor = .blue -> 뷰 대상으로 컨텐트 뷰에 마진을 넣은거라서 빈 공간에도 터치 됨. 백그라운드 색 준 이유: 잊지말라고.
        //        contentView.backgroundColor = .gsLightGray
        
        let bottomButtonStackView = UIStackView(arrangedSubviews: [cameraButton, infoButton])
        bottomButtonStackView.axis = .horizontal
        bottomButtonStackView.distribution = .fillEqually
        
        let labelStackView = UIStackView(arrangedSubviews: [groupNameLabel, dateTimeLabel])
        labelStackView.axis = .vertical
        
        groupImageView.addSubview(labelStackView)
        labelStackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(groupImageView)
        contentView.addSubview(bottomButtonStackView)
        
        groupImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        bottomButtonStackView.backgroundColor = .gsLightGray
        
        bottomButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(groupImageView.snp.bottom)
            make.left.equalTo(groupImageView.snp.left)
            make.right.equalTo(groupImageView.snp.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.top.equalTo(bottomButtonStackView.snp.top)
            make.left.equalTo(bottomButtonStackView.snp.left)
            make.bottom.equalTo(bottomButtonStackView.snp.bottom)
        }
        
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(bottomButtonStackView.snp.top)
            make.left.equalTo(cameraButton.snp.right)
            make.right.equalTo(bottomButtonStackView.snp.right)
            make.bottom.equalTo(bottomButtonStackView.snp.bottom)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public func configure(title: String, date: String, imageURL: String, isCamOn: Bool) {
        self.groupNameLabel.text = title
        self.dateTimeLabel.text = date
        //        self.groupImageView.sd_setImage(with: URL(string: "https://i.picsum.photos/id/603/200/200.jpg?hmac=0BCtNqTfCvRnGEYZ9CJPnBJ8RjT9g0wRO3iDtLHWcnY"))
        //        let urlRequest = URLRequest(url: URL(string: imageURL)!, method: .get)
        
        guard let url = URL(string: AuthService.Constants.baseURL + imageURL) else { print("debug - error"); fatalError("invalid url") }
//        print("debug - url", url)
//        let imageData = NSData(contentsOf: url)
//        print("debug - data", imageData)
//        let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
//        print("debug - base64", strBase64)
        //        let imgData = Data.init(base64Encoded: strBase64 ?? "", options: .init(rawValue: 0))
        ////        let imgData = Data(base64Encoded: strBase64 ?? "")
        //        print("debug - imgData", imgData)
        
//        var urlRequest = URLRequest(url: url)
////        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        print("DEBUG - url", url)
//        urlRequest.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJmcmVzaCIsImlhdCI6MTY2NjUxODc4NiwiZXhwIjoxNjY5MTEwNzg2LCJ1c2VyVUlEIjo0MCwidXNlckF1dGhVSUQiOjIyNn0.IPZGj1GCTwrHkyMNPI3qP3H63chztwPn_LwuAlE4nEg", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: urlRequest) { data, res, err in
//            let string = String(data: data!, encoding: .utf8)!
//            print("DEBUG - data", string)
//            print("DEBUG - res", res)
//        }
//        .resume()
        
        
        //        groupImageView.sd_setImage(with: <#T##URL?#>)
        //        let data = NSData(contentsOf: URL(string: imageURL)!)
        //        NSData
        //        print("debug - data", data)
        //        let image = UIImage(data: data as? Data ?? Data())
        //        print("debug - ", image)
        //        self.groupImageView.image = image
        
        //        self.groupImageView.sd_setImage(with: URL(string: AuthService.Constants.baseURL + imageURL))
//        self.groupImageView.kf.setImage(with: URL(string: AuthService.Constants.baseURL+imageURL))
        //        self.groupImageView.load(url: URL(string: AuthService.Constants.baseURL+imageURL)!)
        
        let cameraButtonColor = isCamOn ? UIColor.gsGreen : UIColor.gsDarkGray
        self.cameraButton.setImage(UIImage(named: "cameraOn")?.withTintColor(cameraButtonColor), for: .normal)
    }
    
    // MARK: - Selectors
    @objc func infoButtonTapped(_ sender: UIButton) {
        guard let safeIndexPath = self.indexPath else { return }
        delegate?.infoButtonTapped(indexPath: safeIndexPath)
    }
}


extension UIImageView {
    func load(url: URL, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                        //                        self?.image = image
                    }
                }
            }
        }
    }
}

