//
//  YJPresentationController.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/17.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class YJPresentationController: UIPresentationController {

    //MARK: - 对外属性
    var presentedFrame: CGRect = CGRect.zero
    
    //MARK: - 懒加载属性
    fileprivate lazy var coverView = UIView()
    
    //MARK:- 系统回调函数
    //重新父类的这个方法改变 frame
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //1.设置弹出 View 的尺寸
        presentedView?.frame = presentedFrame
        
        //2.添加蒙版
        setupCoverView()
    }
}

//MARK: - 设置 UI界面相关

extension YJPresentationController {

    fileprivate func setupCoverView() {
    
        //插入那个空间的后面
        containerView?.insertSubview(coverView, at: 0)
        
        //2.设置蒙版的属性
        
        //或者强制解包
        coverView.frame = containerView?.bounds ?? CGRect.zero
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        
        //3.添加手势
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(YJPresentationController.coverViewClick))
        coverView.addGestureRecognizer(tapGes)
        
    }
}

//MARK: - 事件的点击

extension YJPresentationController {
    
    @objc fileprivate func coverViewClick() {
        DLog("输出了")
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
