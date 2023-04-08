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
        
        guard let url = URL(string: AuthService.Constants.baseURL + imageURL) else { print("debug - error"); fatalError("invalid url") }
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
                    }
                }
            }
        }
    }
}

