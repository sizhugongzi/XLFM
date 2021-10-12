//
//  LiveHeaderGridCell.swift
//  YYSwiftProject
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class LBFMLiveHeaderGridCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(45)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var imageUrl: String? {
        didSet {
            self.imageView.kf.setImage(with: URL(string: imageUrl!))
        }
    }
    
    var titleString: String? {
        didSet {
            self.titleLabel.text = titleString
        }
    }
    
}
