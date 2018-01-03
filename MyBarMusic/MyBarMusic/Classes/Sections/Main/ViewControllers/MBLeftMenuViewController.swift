//
//  MBLeftMenuViewController.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2017/11/14.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit

class MBLeftMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
