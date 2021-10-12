//
//  LBFMLiveCategoryListController.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class LBFMLiveCategoryListController: UIViewController {
    
    private var liveList: [LBFMLivesModel]?
    private let LBFMRecommendLiveCellID = "LBFMRecommendLiveCell"
    
    // 外部传值请求接口如此那
    private var channelId = 0
    convenience init(channelId:Int = 0) {
        self.init()
        self.channelId = channelId
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        // - 注册不同分区cell
        collectionView.register(LBFMRecommendLiveCell.self, forCellWithReuseIdentifier:LBFMRecommendLiveCellID)
        collectionView.uHead = URefreshHeader { [weak self] in self?.setupLoadData() }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(15)
        }
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData() {
        // 首页广播接口请求
        LBFMHomeLiveAPIProvider.request(.categoryLiveList(channelId:self.channelId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LBFMLivesModel>.deserializeModelArrayFrom(json: json["data"]["homePageVo"]["lives"].description) {
                    self.liveList = mappedObject as? [LBFMLivesModel]
                }
                self.collectionView.uHead.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
}

// - collectionviewDelegate
extension LBFMLiveCategoryListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.liveList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LBFMRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMRecommendLiveCellID, for: indexPath) as! LBFMRecommendLiveCell
        cell.liveData = self.liveList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(LBFMScreenWidth - 40)/2,height:230)
    }
    
}
