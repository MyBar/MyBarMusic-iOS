//
//  MBSegmentView.swift
//  MyBarMusic
//
//  Created by lijingui2010 on 2018/3/11.
//  Copyright © 2018年 MyBar. All rights reserved.
//

import UIKit

@objc protocol MBSegmentViewDelegate: NSObjectProtocol {
    func segmentView(_ segmentView: MBSegmentView, didSelectIndexAt index: Int)
}

class MBSegmentView: UIView {

    var itemWidth: CGFloat = 70.0
    //segment 文字数组
    var titleArray: Array<String>! {
        didSet {
            for index in 0 ..< titleArray.count {
                let button = UIButton(type: UIButtonType.custom)
                button.frame = CGRect(x: CGFloat(index) * itemWidth, y: 0, width: itemWidth, height: self.segmentHeight!)
                button.tag = index
                button.setTitle(titleArray[index], for: .normal)
                button.setTitleColor(self.titleNormalColor, for: .normal)
                button.setTitleColor(self.titleSelectColor, for: .selected)
                button.backgroundColor = UIColor.clear
                button.titleLabel?.font = self.titleFont
                button.addTarget(self, action: #selector(buttonIndexClick(_:)), for: UIControlEvents.touchUpInside)
                self.bgScrollView.addSubview(button)

                self.btnArray?.append(button)
                if self.defaultSelectdIndex == index {
                    self.selectBtn = button
                    button.isSelected = true
                }
            }

            self.bgScrollView.contentSize = CGSize(width: itemWidth * CGFloat(titleArray.count), height: self.segmentHeight!)
        }
    }
    //segment 文字颜色
    var titleNormalColor: UIColor? = .lightText
    //segment 选中时文字颜色
    var titleSelectColor: UIColor? = .white
    //segment 文字字体，默认15
    var titleFont: UIFont? = UIFont.systemFont(ofSize: 15.0)
    //segment 默认选中按钮/视图 0
    var defaultSelectdIndex: Int? = 0
    //segment 点击按钮触发事件代理
    var delegate: MBSegmentViewDelegate?

    private var segmentHeight: CGFloat?

    private var segmentWidth: CGFloat?

    private var btnArray: Array<UIButton>? = Array<UIButton>()

    private var bgScrollView: UIScrollView!

    private var selectBtn: UIButton?

    //视图偏移时，控件随着发生变化

    //-(void)dyDidScrollChangeTheTitleColorWithContentOfSet:(CGFloat)width;

    override init(frame: CGRect) {

        self.segmentWidth = frame.width
        self.segmentHeight = frame.height

        self.bgScrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: self.segmentWidth!, height: self.segmentHeight!))
        self.bgScrollView.showsHorizontalScrollIndicator = false

        super.init(frame: frame)

        self.addSubview(self.bgScrollView)

        self.registerKVOPaths()

        //检测滚动
        NotificationCenter.default.addObserver(self, selector: #selector(mainViewScrollDidScroll(notification:)), name: NSNotification.Name(rawValue: "MainViewScrollDidScroll"), object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        for keyPath in self.observeKeyPaths() {
            self.removeObserver(self, forKeyPath: keyPath)
        }

        NotificationCenter.default.removeObserver(self)
    }

    @objc func mainViewScrollDidScroll(notification: Notification) {
        let tag = notification.object as! Int
        let button = self.btnArray![tag]

        if button.tag != self.defaultSelectdIndex {
            self.selectBtn?.isSelected = false
            button.isSelected = true
            self.selectBtn = button
            self.defaultSelectdIndex = button.tag
        }
    }

    func registerKVOPaths() {
        for keyPath in self.observeKeyPaths() {
            self.addObserver(self, forKeyPath: keyPath, options: NSKeyValueObservingOptions.new, context: nil)
        }
    }

    func observeKeyPaths() -> Array<String> {
        return ["titleNormalColor", "titleSelectColor", "titleFont", "defaultSelectIndex"]
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

    }

    func updateUIWithNewValueOfKeypath(_ keyPath: String) {
        switch keyPath {
        case "titleNormalColor":
            self.updateSegmentViewUI(complete: { (button) in
                button.setTitleColor(self.titleNormalColor, for: .normal)
            })
        case "titleSelectColor":
            self.updateSegmentViewUI(complete: { (button) in
                button.setTitleColor(self.titleSelectColor, for: .selected)
            })
        case "titleFont":
            self.updateSegmentViewUI(complete: { (button) in
                button.titleLabel?.font = self.titleFont
            })
        case "defaultSelectIndex":
            self.updateSegmentViewUI(complete: { (button) in
                if button.tag == self.defaultSelectdIndex {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            })
        default:
            print("")
        }

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    func updateSegmentViewUI(complete: ((UIButton) -> Void)?) {
        for button in self.btnArray! {
            button.setTitleColor(self.titleNormalColor, for: .normal)
            button.setTitleColor(self.titleSelectColor, for: .selected)
            button.titleLabel?.font = self.titleFont

            if complete != nil {
                complete!(button)
            }
        }
    }

    @objc func buttonIndexClick(_ sender: UIButton) {
        if self.delegate != nil && (self.delegate?.responds(to: #selector(MBSegmentViewDelegate.segmentView(_:didSelectIndexAt:))))! {
            self.delegate?.segmentView(self, didSelectIndexAt: sender.tag)
        }

        if sender.tag != self.defaultSelectdIndex {
            self.selectBtn?.isSelected = false
            sender.isSelected = true
            self.selectBtn = sender
            self.defaultSelectdIndex = sender.tag
        }
    }

//    //滑动了，根据偏移的量还改变字体颜色
//    func changeTitleColorWithSelectIndex(_ index: Int){
//        // 取出绝对值 避免最左边往右拉时形变超过1
//        let leftIndex = (index - 1 >= 0 ? index - 1 : 0)
//
//        let rightIndex = leftIndex + 1
//
//        print("\(leftIndex) --\(index)-- \(rightIndex)")
//
//        let leftButton = self.btnArray![leftIndex]
//        var rightButton: UIButton?
//        // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
//        if rightIndex < self.btnArray!.count {
//            rightButton = self.btnArray![rightIndex]
//        }
//
//        //计算右边按钮的偏移比 相对比
//        let rightScale = CGFloat(index) - CGFloat(leftIndex)
//
//        //左边按钮的偏移比
//        let leftScale = 1.0 - rightScale
//
//        //按钮文字颜色渐变
//        var normalRed: CGFloat = 0
//        var normalGreen: CGFloat = 0
//        var normalBlue: CGFloat = 0
//        var normalAlpha: CGFloat = 0
//        var selectRed: CGFloat = 0
//        var selectGreen: CGFloat = 0
//        var selectBlue: CGFloat = 0
//        var selectAlpha: CGFloat = 0
//
//        //获取正常设置颜色
//        self.titleNormalColor?.getRed(&normalRed, green: &normalGreen, blue: &normalBlue, alpha: &normalAlpha)
//        self.titleSelectColor?.getRed(&selectRed, green: &selectGreen, blue: &selectBlue, alpha: &selectAlpha)
//
//        //选中和未选中的色差
//        let redDif = selectRed - normalRed
//        let greenDif = selectGreen - normalGreen
//        let blueDif = selectBlue - normalBlue
//        let alphaDif = selectAlpha - normalAlpha
//
//        leftButton.titleLabel?.textColor = UIColor(red: leftScale * redDif + normalRed, green: leftScale * greenDif + normalGreen, blue: leftScale * blueDif + normalBlue, alpha: leftScale * alphaDif + normalAlpha)
//        rightButton?.titleLabel?.textColor = UIColor(red: rightScale * redDif + normalRed, green: rightScale * greenDif + normalGreen, blue: rightScale * blueDif + normalBlue, alpha: rightScale * alphaDif + normalAlpha)
//    }
}
