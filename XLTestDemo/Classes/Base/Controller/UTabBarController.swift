//
//  UTabBarController.swift
//  U17
//
//  Created by apple on 2021/7/8.
//  Copyright © 2021 apple. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
  
        /// 首页
        let onePageVC = HomeCategoryViewController()
        addChildViewController(onePageVC,
                               title: "首页",
                               image: UIImage(named: "home"),
                               selectedImage: UIImage(named: "home_1"))
        
        /// 我听
        let classVC = LBFMListenController()
        addChildViewController(classVC,
                               title: "我听",
                               image: UIImage(named: "find"),
                               selectedImage: UIImage(named: "find_1"))
        
        
        /// 推荐
        let findVC = ViewController()
        addChildViewController(findVC,
                               title: "",
                               image: UIImage(named: "tab_play"),
                               selectedImage: UIImage(named: "tab_play"))
        
        /// 发现
        let bookVC = LBFMFindController()
        addChildViewController(bookVC,
                               title: "发现",
                               image: UIImage(named: "favor"),
                               selectedImage: UIImage(named: "favor_1"))
        
        /// 我的
        let mineVC = LBFMMineController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "me"),
                               selectedImage: UIImage(named: "me_1"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.automatic))
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        addChild(UNavigationController(rootViewController: childController))
    }
    
}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
