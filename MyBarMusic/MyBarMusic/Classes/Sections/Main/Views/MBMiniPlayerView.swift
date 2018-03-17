//
//  MBMiniPlayerView.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2017/11/22.
//  Copyright © 2017年 MyBar. All rights reserved.
//

import UIKit

class MBMiniPlayerView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nonePlaylistLabel: UILabel!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playlistButton: UIButton!
    @IBOutlet weak var albumCoverScrollView: UIScrollView!

    var preMiniPlayerAlbumCoverView: MBMiniPlayerAlbumCoverView?
    var currentMiniPlayerAlbumCoverView: MBMiniPlayerAlbumCoverView?
    var nextMiniPlayerAlbumCoverView: MBMiniPlayerAlbumCoverView?

    var playerCircularProgressView: MBPlayerCircularProgressView!

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialFromXib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialFromXib()
    }
    
    fileprivate func initialFromXib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MBMiniPlayerView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView.frame = bounds
        self.addSubview(self.contentView)

        self.playlistButton.frame.size = CGSize(width: self.contentView.frame.height, height: self.contentView.frame.height)
        self.playView.frame.size = self.playlistButton.frame.size
        self.albumCoverScrollView.frame.size = CGSize(width: self.contentView.frame.width - self.playlistButton.frame.width - self.playView.frame.width, height: self.contentView.frame.height)

        let backColor = UIColor(patternImage: UIImage(named: "player_slider_playback_left")!) //UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        let progressColor = backColor //UIColor(red: 82.0/255.0, green: 135.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        var frame = CGRect(x: 0, y: 0, width: self.playView.bounds.width / 1.3, height: self.playView.bounds.height / 1.3)
        frame.origin = CGPoint(x: (self.playView.bounds.width - frame.width) / 2.0, y: (self.playView.bounds.height - frame.height) / 2.0)
        self.playerCircularProgressView = MBPlayerCircularProgressView(frame: frame, backColor: backColor, progressColor: progressColor, lineWidth: 3)
        self.playerCircularProgressView.backgroundColor = UIColor(patternImage: UIImage(named: "vc_bg")!)
        //self.playerCircularProgressView.isEnabled = false
        self.playView.addSubview(self.playerCircularProgressView)

        initAlbumCoverScrollView()
    }

    fileprivate func initAlbumCoverScrollView() {
        let preFrame = CGRect(x: 0, y: self.albumCoverScrollView.frame.origin.y, width: self.albumCoverScrollView.frame.width, height: self.albumCoverScrollView.frame.height)
        self.preMiniPlayerAlbumCoverView = MBMiniPlayerAlbumCoverView(frame: preFrame)
        self.albumCoverScrollView.addSubview(self.preMiniPlayerAlbumCoverView!)

        let currentFrame = CGRect(x: self.albumCoverScrollView.frame.width, y: self.albumCoverScrollView.frame.origin.y, width: self.albumCoverScrollView.frame.width, height: self.albumCoverScrollView.frame.height)
        self.currentMiniPlayerAlbumCoverView = MBMiniPlayerAlbumCoverView(frame: currentFrame)
        self.albumCoverScrollView.addSubview(self.currentMiniPlayerAlbumCoverView!)

        let nextFrame = CGRect(x: self.albumCoverScrollView.frame.width * CGFloat(2), y: self.albumCoverScrollView.frame.origin.y, width: self.albumCoverScrollView.frame.width, height: self.albumCoverScrollView.frame.height)
        self.nextMiniPlayerAlbumCoverView = MBMiniPlayerAlbumCoverView(frame: nextFrame)
        self.albumCoverScrollView.addSubview(self.nextMiniPlayerAlbumCoverView!)

        self.albumCoverScrollView.contentSize = CGSize(width: self.albumCoverScrollView.frame.width * CGFloat(3), height: 0)
        self.albumCoverScrollView.contentOffset = CGPoint(x: self.albumCoverScrollView.frame.width, y: 0)

        self.albumCoverScrollView.delegate = self
    }
}

extension MBMiniPlayerView: UIScrollViewDelegate {
    /** 滚动结束后调用（代码导致） */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //关于设置一个范围因为调试的时候发现contentOffset.x有时候不是0，self.scrollView.frame.width, self.scrollView.frame.width * CGFloat(2)
        if scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x <= 10 {

            for miniPlayerAlbumCoverView in scrollView.subviews {
                miniPlayerAlbumCoverView.removeFromSuperview()
            }

            self.initAlbumCoverScrollView()
        }

        if scrollView.contentOffset.x >= scrollView.frame.width * CGFloat(2) - 10 && scrollView.contentOffset.x <= scrollView.frame.width * CGFloat(2) + 10 {

            for miniPlayerAlbumCoverView in scrollView.subviews {
                miniPlayerAlbumCoverView.removeFromSuperview()
            }

            self.initAlbumCoverScrollView()
        }
    }
}
