//
//  LBFMHomeLiveController.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import JXSegmentedView

extension LBFMHomeLiveController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
    func listDidAppear() {
        print("listDidAppear")
    }
    
    func listDidDisappear() {
        print("listDidDisappear")
    }
    
}

let LBFMHomeLiveSectionGrid     = 0   // 分类section
let LBFMHomeLiveSectionBanner   = 1   // 滚动图片section
let LBFMHomeLiveSectionRank     = 2   // 排行榜section
let LBFMHomeLiveSectionLive     = 3   // 直播section

/// 首页直播控制器
class LBFMHomeLiveController: UIViewController {
    
    var lives: [LBFMLivesModel]?
    private let LBFMHomeLiveHeaderViewID = "LBFMHomeLiveHeaderView"
    private let LBFMHomeLiveGridCellID   = "LBFMHomeLiveGridCell"
    private let LBFMHomeLiveBannerCellID = "LBFMHomeLiveBannerCell"
    private let LBFMHomeLiveRankCellID   = "LBFMHomeLiveRankCell"
    private let LBFMRecommendLiveCellID = "LBFMRecommendLiveCell"
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        // 注册头视图和尾视图
        collectionView.register(LBFMHomeLiveHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMHomeLiveHeaderViewID)
        // 注册不同分区cell
        collectionView.register(LBFMRecommendLiveCell.self, forCellWithReuseIdentifier: LBFMRecommendLiveCellID)
        collectionView.register(LBFMHomeLiveGridCell.self, forCellWithReuseIdentifier:LBFMHomeLiveGridCellID)
        collectionView.register(LBFMHomeLiveBannerCell.self, forCellWithReuseIdentifier:LBFMHomeLiveBannerCellID)
        collectionView.register(LBFMHomeLiveRankCell.self, forCellWithReuseIdentifier:LBFMHomeLiveRankCellID)
        collectionView.uHead = URefreshHeader{ [weak self] in self?.loadLiveData() }
        return collectionView
    }()
    
    lazy var viewModel: LBFMHomeLiveViewModel = {
        return LBFMHomeLiveViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        // 刚进页面进行刷新
        self.collectionView.uHead.beginRefreshing()
        loadLiveData()
    }
    
    func loadLiveData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
}

// - collectionviewDelegate
extension LBFMHomeLiveController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case LBFMHomeLiveSectionGrid:
            let cell: LBFMHomeLiveGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMHomeLiveGridCellID, for: indexPath) as! LBFMHomeLiveGridCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.delegate = self
            return cell
        case LBFMHomeLiveSectionBanner:
            let cell: LBFMHomeLiveBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMHomeLiveBannerCellID, for: indexPath) as! LBFMHomeLiveBannerCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.bannerList = viewModel.homeLiveBanerList
            return cell
        case LBFMHomeLiveSectionRank:
            let cell: LBFMHomeLiveRankCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMHomeLiveRankCellID, for: indexPath) as! LBFMHomeLiveRankCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.multidimensionalRankVos = viewModel.multidimensionalRankVos
            return cell
        default:
            let cell: LBFMRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBFMRecommendLiveCellID, for: indexPath) as! LBFMRecommendLiveCell
            cell.liveData = viewModel.lives?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: LBFMHomeLiveHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LBFMHomeLiveHeaderViewID, for: indexPath) as! LBFMHomeLiveHeaderView
            headerView.delegate = self
            headerView.backgroundColor = UIColor.white
            return headerView
        }else {
            return UICollectionReusableView()
        }
    }
    
}

// - 点击顶部分类按钮 delegate
extension LBFMHomeLiveController: LBFMHomeLiveGridCellDelegate {
    
    func homeLiveGridCellItemClick(channelId: Int,title:String) {
        let vc = LBFMLiveCategoryListController(channelId: channelId)
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// - 点击中间直播item上分类按钮 delegate
extension LBFMHomeLiveController: LBFMHomeLiveHeaderViewDelegate {
    
    func homeLiveHeaderViewCategoryBtnClick(button: UIButton) {
        viewModel.categoryType = button.tag - 988
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshCategoryLiveData()
    }
    
}


