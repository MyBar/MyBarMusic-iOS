//
//  MBMainViewController.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2017/11/14.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit

class MBMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    fileprivate func setNavigationBar() {

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "vc_head_bg"), for: UIBarMetrics.default)
    }
}
