//
//  ViewController.swift
//  XLTestDemo
//
//  Created by apple on 2021/7/8.
//  Copyright Β© 2021 apple. All rights reserved.
//

import UIKit
import SwiftMessages

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 0.5)
        test()
    }
    
    func test() {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["πΈ", "π·", "π¬", "π ", "π", "πΉ", "πΌ"].randomElement()!
        warning.configureContent(title: "Warning", body: "ζζΆζ²‘ζζ­€εθ½", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
    
}


