//
//  MBMiniPlayerAlbumCoverView.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2018/1/10.
//  Copyright © 2018年 MyBar. All rights reserved.
//

import UIKit

class MBMiniPlayerAlbumCoverView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lyricLabel: UILabel!
    
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
        let nib = UINib(nibName: "MBMiniPlayerAlbumCoverView", bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.contentView.frame = bounds
        self.addSubview(self.contentView)

        self.albumImageView.layer.cornerRadius = self.albumImageView.frame.width * 0.5
        self.albumImageView.layer.masksToBounds = true
    }
}
