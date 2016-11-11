//
//  ComposeViewController.swift
//  WeBo
//
//  Created by Apple on 16/11/9.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    //MARK:- 控件属性
    var textView: ComposeTextView = ComposeTextView(coder: <#T##NSCoder#>)!
    
    //MARK:- 懒加载属性
    
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
