//
//  LBFMFindHeaderView.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class LBFMFindHeaderView: UIView {
    
    let dataArray = ["电子书城","全民朗读","大咖主播","活动","直播微课","听单","游戏中心","边听变看","商城","0元购"]
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: (LBFMScreenWidth - 30) / 5, height:90)
        let collectionView = UICollectionView.init(frame:CGRect(x:15, y:0, width:LBFMScreenWidth - 30, height:180), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(LBFMFindCell.self, forCellWithReuseIdentifier:"LBFMFindCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.collectionView)
        let footerView = UIView()
        footerView.backgroundColor = LBFMDownColor
        self.addSubview(footerView)
        footerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension LBFMFindHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LBFMFindCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LBFMFindCell", for: indexPath) as! LBFMFindCell
        cell.dataString = self.dataArray[indexPath.row]
        return cell
    }
    
}

