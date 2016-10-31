//
//  BaseViewController.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    //MARK:- 懒加载属性
    lazy var visitorView = VisitorView.visitorView()
    
    //MARK:- 定义变量
    var isLogin: Bool = false

  
    //MARK:- 系统回调函数
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
    }
}

//MARK:- 设置 UI 界面
extension BaseViewController {
  
    //MARK:- 设置访客视图
    fileprivate func setupVisitorView() {
        
        view = visitorView
        
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginBtnClick), for: .touchUpInside)
    }
    
    //MARK:- 设置导航栏的 item
    fileprivate func setupNavigationItems() {
    
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "注册", style: .plain, target: self, action: #selector(BaseViewController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "登录", style: .plain, target: self, action: #selector(BaseViewController.loginBtnClick))
    }

}

//MARK:- 监听事件的响应
extension BaseViewController {

    //注册
   @objc fileprivate func registerBtnClick() {
    
    DLog("点击了注册")
    }
    
    //登录
   @objc fileprivate func loginBtnClick() {
    
    DLog("点击了登录")
    let oauthVC = OAuthViewController()
    let navViewController = UINavigationController.init(rootViewController: oauthVC)
    present(navViewController, animated: true, completion: nil)
    }

}
