//
//  HomeViewController.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SVProgressHUD
class HomeViewController: BaseViewController {
 
    //MARK:- 懒加载属性
    fileprivate lazy var titleBtn: TitleButton = TitleButton()
    // 注意:在闭包中如果使用当前对象的属性或者调用方法,也需要加self
    // 两个地方需要使用self : 1> 如果在一个函数中出现歧义 2> 在闭包中使用当前对象的属性和方法也需要加self
    
    fileprivate lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[weak self] (presented) -> () in
        self?.titleBtn.isSelected = presented
    }
    
    fileprivate lazy var dataArr: [StatusViewModel] = [StatusViewModel]()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //1. 没有登录时设置的内容
        visitorView.addRotationAnimation()
        if !isLogin {
            return
        }

        //2.设置导航栏的内容
        setupNavigationBar()
        
        //注册 tableViewCell
        self.tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200

        //请求网络数据
        loadStatuses() 
    }
}

//MARK: - 设置 UI 界面
extension HomeViewController {

    fileprivate func setupNavigationBar() {
    
        //1.设置左侧的 Item
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(target: self, action: #selector(HomeViewController.leftBtnClick), image: "navigationbar_friendattention")
        
        //2.设置右侧的 Item
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(target: self, action: #selector(HomeViewController.rightBtnClick), image: "navigationbar_pop")
        
        //3.设置 titleView
        titleBtn.setTitle("首页", for: UIControlState())
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

//MARK:- 事件的点击
extension HomeViewController {
  
    @objc fileprivate func leftBtnClick() {
    
        DLog("点击的是左边的 btn")
    }
    
    @objc fileprivate func rightBtnClick
        () {
        DLog("点击的是右边的 btn")
    }
    
    @objc fileprivate func titleBtnClick(_ titleBtn: TitleButton) {

        //1.创建弹出的控制器
        let popoverVC = PopoverViewController()
        
        //2.设置控制器 modal 样式.设置custom样式 HomeVC 不会被移除
        popoverVC.modalPresentationStyle = .custom
        
        //3.设置转场代理
        popoverVC.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: 115, y: 55, width: 180, height: 250)
        
        //4.弹出视图
        present(popoverVC, animated: true, completion: nil)
    }
}

//MARK:- 请求网络数据
extension HomeViewController {

    fileprivate func loadStatuses() {
    
        SVProgressHUD.show(withStatus: "正在加载...")
        NetworkTools.shareInstance.loadStatus { (result, error) -> (Void) in
            SVProgressHUD.dismiss()
            // 1.错误信息校验
            if error != nil {
            DLog(error)
                return
            }
            // 2.获取可选类型中的数据
            guard let resultArray = result else {
                return
            }
            // 3.遍历微博对应的字典
            for statusDict in resultArray {
                let model = StatusModel(dict: statusDict)
                let viewModel = StatusViewModel(status: model)
                self.dataArr.append(viewModel)
            }
            //刷新表
            self.tableView.reloadData()
        }
    }
}

//MARK:- UITableViewDataSouce
extension HomeViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        
        cell.viewModel = self.dataArr[indexPath.row]
        return cell
    }
}
