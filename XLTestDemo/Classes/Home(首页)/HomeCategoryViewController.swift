//
//  HomeCategoryViewController.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import JXSegmentedView
import SnapKit
import Alamofire

//分类页面
class HomeCategoryViewController: UIViewController {
    
    var segmentedDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    //标题tab数据
    private let tabTitles = ["推荐","分类","VIP","直播","广播"]
    
    private let oneVc = LBFMHomeRecommendController()
    private let twoVc = LBFMHomeClassifyController()
    private let threeVc = LBFMHomeVIPController()
    private let fourVc = LBFMHomeLiveController()
    private let fiveVc = LBFMHomeBroadcastController()
    private lazy var viewControllers: [UIViewController] = {
        return [oneVc, twoVc, threeVc, fourVc, fiveVc]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        //直接隐藏bar
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //1、初始化JXSegmentedView
        segmentedView = JXSegmentedView()
        
        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = tabTitles
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedView.dataSource = segmentedDataSource
        
        //3、配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = .lengthen
        segmentedView.indicators = [indicator]
        
        //4、配置JXSegmentedView的属性
        view.addSubview(segmentedView)
        
        //5、初始化JXSegmentedListContainerView
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(listContainerView)
        
        //6、将listContainerView.scrollView和segmentedView.contentScrollView进行关联
        segmentedView.listContainer = listContainerView
        
        //布局子控件,
        segmentedView.snp.makeConstraints { (make) in
            //tab的宽度等于屏幕宽度
            make.width.equalToSuperview()
            //tab高度44
            make.height.equalTo(44)
            //tab的顶部,在安全区顶部
            make.top.equalTo(LBFMStatusBarHeight)
        }
        
        listContainerView.snp.makeConstraints { (make) in
            //可以滑动的容器,在tab的下面,宽度屏幕宽,底部在安全区的最下边
            make.top.equalTo(segmentedView.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
        
        //获取分类数据
        getCategories()
    }
    
    //获取分类的数据
    func getCategories() {
        //把获取的分类数组设置到tab中
        segmentedDataSource.titles = tabTitles
        //显示当前tab的第一个位置
        segmentedView.defaultSelectedIndex = 0
        //设置数据之后,需要刷新
        segmentedView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //视图将出现,显示
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension HomeCategoryViewController: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        //tab的总个数
        return segmentedDataSource.dataSource.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        //当切换的时候,加载不同的页面
        var vc: UIViewController?
        vc = viewControllers[index]
        return vc as! JXSegmentedListContainerViewListDelegate
    }
    
}

