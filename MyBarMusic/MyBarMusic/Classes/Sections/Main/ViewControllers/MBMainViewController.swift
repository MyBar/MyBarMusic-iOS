//
//  MBMainViewController.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2017/11/14.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MBMainViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var miniPlayeContainerView: UIView!
    @IBOutlet weak var pageScrollView: UIScrollView!

    var miniPlayerView: MBMiniPlayerView!

    var titleSegmentView: MBSegmentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setSearchView()
        setPageScrollView()
        setMiniPlayerView()
    }

    fileprivate func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "vc_head_bg"), for: UIBarMetrics.default)

        self.addLeftBarButtonWithImage(UIImage(named: "navagation_btn_default")!.withRenderingMode(.alwaysOriginal))

        self.addRightBarButtonWithImage(UIImage(named: "top_tab_more")!.withRenderingMode(.alwaysOriginal))

        self.titleSegmentView = MBSegmentView(frame: CGRect(x: (UIScreen.main.bounds.width - 210.0) / 2.0, y: 0, width: 210, height: 44))
        self.titleSegmentView.delegate = self
        self.titleSegmentView.titleFont = UIFont.systemFont(ofSize: 20)
        self.titleSegmentView.defaultSelectdIndex = 1
        self.titleSegmentView.titleArray = ["我的", "音乐馆", "发现"]
        self.navigationItem.titleView = self.titleSegmentView
    }

    func setSearchView() {
        self.searchView.backgroundColor = UIColor(patternImage: UIImage(named: "vc_head_bg")!)
    }

    func setMiniPlayerView() {
        self.miniPlayeContainerView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(60.0))
        let miniPlayerView = MBMiniPlayerView(frame: CGRect(x: 0, y: 0, width: self.miniPlayeContainerView.bounds.width, height: self.miniPlayeContainerView.frame.height))
        self.miniPlayeContainerView.addSubview(miniPlayerView)
        self.miniPlayerView = miniPlayerView
    }

    func setPageScrollView() {
        self.pageScrollView.delegate = self
        self.pageScrollView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: self.pageScrollView.frame.height)

        addChildViewController()

        let contentWidth = CGFloat(3) * self.pageScrollView.bounds.width
        self.pageScrollView.contentSize = CGSize(width: contentWidth, height: 0)
        self.pageScrollView.contentOffset = CGPoint(x: self.pageScrollView.bounds.width * CGFloat(self.titleSegmentView.defaultSelectdIndex!), y: 0)
    }

    /** 添加子控制器 */
    fileprivate func addChildViewController() {
        let mineViewController = UIStoryboard(name: "Mine", bundle: Bundle.main).instantiateInitialViewController()
        self.addChildViewController(mineViewController!)
        mineViewController!.view.frame = self.pageScrollView.bounds
        self.pageScrollView.addSubview(mineViewController!.view)
        
        let channelViewController = UIStoryboard(name: "Channel", bundle: Bundle.main).instantiateInitialViewController()
        self.addChildViewController(channelViewController!)
        channelViewController!.view.frame = CGRect(x: self.pageScrollView.frame.width, y: 0, width: self.pageScrollView.frame.width, height: self.pageScrollView.frame.height)
        self.pageScrollView.addSubview(channelViewController!.view)

        let discoverViewController = UIStoryboard(name: "Discover", bundle: Bundle.main).instantiateInitialViewController()
        self.addChildViewController(discoverViewController!)
        discoverViewController!.view.frame = CGRect(x: self.pageScrollView.frame.width * CGFloat(2), y: 0, width: self.pageScrollView.frame.width, height: self.pageScrollView.frame.height)
        self.pageScrollView.addSubview(discoverViewController!.view)
    }
}

extension MBMainViewController: UIScrollViewDelegate {
    /** 滚动结束后调用（代码导致） */
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // 获得索引
        let index  = Int(scrollView.contentOffset.x / scrollView.bounds.width)

        if index == 0 {
            scrollView.bounces = false
            SlideMenuOptions.leftBezelWidth = 16.0
        } else {
            scrollView.bounces = true
            SlideMenuOptions.leftBezelWidth = 0.0
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MainViewScrollDidScroll"), object: index)
    }

    /** 滚动结束（手势导致） */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
}

extension MBMainViewController: MBSegmentViewDelegate {
    func segmentView(_ segmentView: MBSegmentView, didSelectIndexAt index: Int) {
        self.pageScrollView.contentOffset = CGPoint(x: self.pageScrollView.bounds.width * CGFloat(index), y: 0)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MainViewScrollDidScroll"), object: index)

    }


}
