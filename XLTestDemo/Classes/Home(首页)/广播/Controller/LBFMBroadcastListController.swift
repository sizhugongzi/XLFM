//
//  LBFMBroadcastListController.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LBFMBroadcastListController: UIViewController {
    
    private var topRadiosModel: [LBFMTopRadiosModel]?
    private let LBFMHomeRadiosCellID = "LBFMHomeRadiosCell"
    
    // 外部传值请求接口
    private var url: String?
    private var categoryId = 0
    private var isMoreCategory: Bool = false
    convenience init(url: String?, categoryId: Int = 0, isMoreCategory: Bool = false) {
        self.init()
        self.url = url
        self.categoryId = categoryId
        self.isMoreCategory = isMoreCategory
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        // 注册不同分区cell
        collectionView.register(LBFMHomeRadiosCell.self, forCellWithReuseIdentifier:LBFMHomeRadiosCellID)
        if isMoreCategory {
            collectionView.uHead = URefreshHeader { [weak self] in self?.loadMoreCategoryData() }
        } else {
            collectionView.uHead = URefreshHeader { [weak self] in self?.setupLoadData() }
        }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        if isMoreCategory {
            loadMoreCategoryData()
        } else {
            setupLoadData()
        }
    }
    
    func setupLoadData() {
        // 首页广播接口请求
        LBFMHomeBroadcastAPIProvider.request(.categoryBroadcastList(path:self.url!)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMTopRadiosModel>.deserializeModelArrayFrom(json: json["data"]["data"].description) {
                    self.topRadiosModel = mappedObject as? [LBFMTopRadiosModel]
                }
                self.collectionView.uHead.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    func loadMoreCategoryData() {
        // 首页广播接口请求
        LBFMHomeBroadcastAPIProvider.request(.moreCategoryBroadcastList(categoryId:self.categoryId)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMTopRadiosModel>.deserializeModelArrayFrom(json: json["data"]["data"].description) {
                    self.topRadiosModel = mappedObject as? [LBFMTopRadiosModel]
                }
                self.collectionView.uHead.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
}

// - collectionviewDelegate
extension LBFMBroadcastListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topRadiosModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LBFMHomeRadiosCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMHomeRadiosCellID, for: indexPath) as! LBFMHomeRadiosCell
        cell.topRadioModel = self.topRadiosModel?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:LBFMScreenWidth,height:120)
    }
    
}
