//
//  MBPlayerCircularProgressView.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2018/1/27.
//  Copyright © 2018年 MyBar. All rights reserved.
//

import UIKit

class MBPlayerCircularProgressView: UIView {

    var backColor: UIColor!
    var progressColor: UIColor!
    var lineWidth: CGFloat!
    var progress: Float!
    var imageView: UIImageView = UIImageView()

    var isPlaying: Bool {
        didSet {
            if isEnabled {
                if isPlaying {
                    self.imageView.image = UIImage(named: "miniplayer_btn_pause_normal")
                } else {
                    self.imageView.image = UIImage(named: "miniplayer_btn_play_normal")
                }
            }
        }
    }

    var isEnabled: Bool {
        didSet {
            if !isEnabled {
                self.imageView.image = UIImage(named: "miniplayer_btn_play_disable")
            }
            print("Hello")
        }
    }

    init(frame: CGRect, backColor: UIColor, progressColor: UIColor, lineWidth: CGFloat, isEnabled: Bool = true, isPlaying: Bool = true) {
        self.backColor = backColor
        self.progressColor = progressColor
        self.lineWidth = lineWidth
        self.progress = 0
        self.isEnabled = isEnabled
        self.isPlaying = isPlaying

        super.init(frame: frame)

        self.imageView.frame = self.bounds
        //self.imageView.center = self.center
        //self.imageView.frame.size = CGSize(width: self.bounds.width / 2.0, height: self.bounds.height / 2.0)
        self.imageView.image = UIImage(named: "miniplayer_btn_pause_normal")
        self.addSubview(self.imageView)

        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if self.isEnabled {
            let backCircleBezierPath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2), radius: self.bounds.size.width / 2 - self.lineWidth / 2, startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
            self.backColor.setStroke()
            backCircleBezierPath.lineWidth = self.lineWidth
            backCircleBezierPath.stroke()

            if self.progress != 0 {
                let arcCenter = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
                let radius = self.bounds.size.width / 2 - self.lineWidth
                let endAngle = CGFloat(-Double.pi / 2
                    ) + CGFloat(self.progress * 2) * CGFloat(Double.pi)
                let progressCircleBezierPath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(-Double.pi / 2), endAngle: endAngle, clockwise: true)
                self.progressColor.setStroke()
                progressCircleBezierPath.lineWidth = self.lineWidth
                progressCircleBezierPath.stroke()
            }
        }
    }
}
