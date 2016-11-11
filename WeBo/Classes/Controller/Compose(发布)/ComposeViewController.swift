//
//  ComposeViewController.swift
//  WeBo
//
//  Created by Apple on 16/11/9.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    //MARK:- 懒加载属性
    fileprivate lazy var textView: ComposeTextView = ComposeTextView()
    fileprivate lazy var titleView: ComposeTitleView = ComposeTitleView()
    
    //MARK:- 系统回掉函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK:- UI界面相关
extension ComposeViewController {

    // 1. 设置左右的 item
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(ComposeViewController.closeItemBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(ComposeViewController.sendItemBtnClick))
        navigationItem.title = "发微博"
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.equalTo(self.view).offset(12)
            make.right.equalTo(self.view).offset(-12)
        }
        
    }
}

//MARK:- 点击事件
extension ComposeViewController {

    @objc fileprivate func closeItemBtnClick() {
    
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendItemBtnClick() {
    
    }
}
