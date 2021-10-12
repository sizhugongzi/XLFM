//
//  LBFMHeader.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON


let LBFMScreenWidth = UIScreen.main.bounds.size.width
let LBFMScreenHeight = UIScreen.main.bounds.size.height

let LBFMButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let LBFMDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
//let isIphoneX = LBFMScreenHeight == 812 ? true : false

// LBFMStatusBarHeight
let LBFMStatusBarHeight: CGFloat = isIphoneX ? 44 : 20

// LBFMNavBarHeight
let LBFMNavBarHeight: CGFloat = isIphoneX ? 88 : 64

// LBFMTabBarHeight
let LBFMTabBarHeight: CGFloat = isIphoneX ? 49 + 34 : 49

