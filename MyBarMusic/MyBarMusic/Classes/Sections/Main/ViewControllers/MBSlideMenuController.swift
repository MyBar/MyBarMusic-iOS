//
//  MBSlideMenuController.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2017/11/14.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MBSlideMenuController: SlideMenuController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func awakeFromNib() {
        SlideMenuOptions.hideStatusBar = false
        SlideMenuOptions.leftViewWidth = UIScreen.main.bounds.width * 0.85
        SlideMenuOptions.leftBezelWidth = 0.0
        SlideMenuOptions.contentViewScale = 1.0
        SlideMenuOptions.contentViewDrag = true
        SlideMenuOptions.simultaneousGestureRecognizers = true
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "MBMainNavController") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "MBLeftMenuNavController") {
            self.leftViewController = controller
        }
        
        super.awakeFromNib()
    }
}
