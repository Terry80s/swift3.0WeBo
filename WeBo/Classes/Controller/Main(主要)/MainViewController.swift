//
//  MainViewController.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    //MARK: - 懒加载控件
//    private lazy var composeBtn: UIButton = UIButton.createButton("tabbar_compose_icon_add", bgImagename: "tabbar_compose_button")
    
    fileprivate lazy var composeBtn: UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    //MARK: -系统回掉函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeBtn()
        
        addChildViewController()
    }
    
    //如果需要设置 item 不可以点击需要在 viewviewWillAppear 中设置,否则无效
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTabbarItems()
    }
}

// MARK: - 设置 UI 界面
extension MainViewController {

    //设置加号按钮
    fileprivate func setupComposeBtn() {
        
        tabBar.addSubview(composeBtn)
      
        //设置位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        //监听事件的点击有两种方法
        //1.Selector("这里是一个字符串")
        //2.直接写一个"字符串"
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), for: .touchUpInside)
    }
    
    fileprivate func addChildViewController() {
        //设置全局颜色
        UITabBar.appearance().tintColor = UIColor.orange
        //设置导航按钮的颜色
        UINavigationBar.appearance().tintColor = UIColor.orange
        //添加子控制器
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(HomeViewController(), title: "", imageName: "")
        addChildViewController(DiscoverViewController(), title: "发现", imageName: "tabbar_home")
        addChildViewController(ProfileViewController(), title: "我的", imageName: "tabbar_home")
        
    }
    
    //swift 支持方法的重载
    //方法的重载:方法名称相同,但参数不同,--> 1.参数的类型不同 2. 参数的个数不同
    // private在当前文件中可以访问,但是其他文件不能访问
    fileprivate func addChildViewController(_ childVC: UIViewController, title: String, imageName: String) {
        
        //1.设置子控制器的属性
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        //2.包装导航栏控制器
        let childNav = UINavigationController(rootViewController: childVC)
        
        //3.添加控制器
        addChildViewController(childNav)
    }

    fileprivate func setupTabbarItems() {
    
        //1.遍历所有的 item
        for i in 0..<tabBar.items!.count {
            
            //2. 获取 item
            let item = tabBar.items![i]
            
            //3.如果是下标值为2, 则该item不可以和用户交互
            if i == 2 {
                item.isEnabled = false
                //跳出本次循环
                continue
            }
        }
    }
}

//MARK: - 事件的监听
extension MainViewController {
    
    //事件监听本质是发送消息,发送消息是 OC 的特性
    //将方法包装成@ SEL --> 类中查找方法列表 --> 根据@ SEL找到 imp指针(函数指针)
    //如果 swift 中将一个函数声明称 private, 那么该函数不会被添加到方法列表中
    
    @objc fileprivate func composeBtnClick() {
       DLog("点击了")
        
    }
}
