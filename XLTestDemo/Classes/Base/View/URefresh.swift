//
//  URefresh.swift
//  U17
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var uHead: MJRefreshHeader {
        get { return mj_header! }
        set { mj_header = newValue }
    }
    
    var uFoot: MJRefreshFooter {
        get { return mj_footer! }
        set { mj_footer = newValue }
    }
}

class URefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .idle)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .pulling)
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!,
                   UIImage(named: "pullToRefresh_1_80x60_")!,
                   UIImage(named: "pullToRefresh_2_80x60_")!,
                   UIImage(named: "pullToRefresh_3_80x60_")!,
                   UIImage(named: "pullToRefresh_4_80x60_")!,
                   UIImage(named: "pullToRefresh_5_80x60_")!,
                   UIImage(named: "pullToRefresh_6_80x60_")!,
                   UIImage(named: "pullToRefresh_7_80x60_")!,
                   UIImage(named: "pullToRefresh_8_80x60_")!,
                   UIImage(named: "pullToRefresh_9_80x60_")!], for: .refreshing)
        
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
    }
}

class URefreshAutoHeader: MJRefreshHeader {}

class URefreshFooter: MJRefreshBackNormalFooter {}

class URefreshAutoFooter: MJRefreshAutoFooter {}


class URefreshDiscoverFooter: MJRefreshBackGifFooter {
    
    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.clear
        setImages([UIImage(named: "pullToRefresh_0_80x60_")!], for: .idle)
        stateLabel?.isHidden = true
        refreshingBlock = { self.endRefreshing() }
    }
}

class URefreshTipKissFooter: MJRefreshBackFooter {
    
    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.numberOfLines = 0
        return tl
    }()
    
    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "pullToRefresh_0_80x60_")
        return iw
    }()
    
    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.clear
        mj_h = 240
        addSubview(tipLabel)
        addSubview(imageView)
    }
    
    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 40, width: bounds.width, height: 60)
        imageView.frame = CGRect(x: (bounds.width - 80 ) / 2, y: 110, width: 80, height: 80)
    }
    
    convenience init(with tip: String) {
        self.init()
        refreshingBlock = { self.endRefreshing() }
        tipLabel.text = tip
    }
    
}



