//
//  HomeViewController.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage
import MJRefresh
class HomeViewController: BaseViewController {
 
    //MARK:- 懒加载属性
    fileprivate lazy var titleBtn: TitleButton = TitleButton()
    // 注意:在闭包中如果使用当前对象的属性或者调用方法,也需要加self
    // 两个地方需要使用self : 1> 如果在一个函数中出现歧义 2> 在闭包中使用当前对象的属性和方法也需要加self
    
    fileprivate lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[weak self] (presented) -> () in
        self?.titleBtn.isSelected = presented
    }
    
    fileprivate lazy var dataArr: [StatusViewModel] = [StatusViewModel]()
    
    fileprivate lazy var tipLab: UILabel = UILabel()
    
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
        //给定 cell 一个最大的高度
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 1000

        //设置上下拉刷新
        setupHeaderView()
        //设置上啦加载更多
        setupFooterView()
        
        //设置提示Lable
        setupTipLabel()
        
        // 6.监听通知
        setupNatifications()
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
    
    fileprivate func setupHeaderView() {
        // 1.创建headerView
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadNewStatuses))
        
        // 2.设置 header的属性
    
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放更新", for: .pulling)
        header?.setTitle("加载中", for: .refreshing)
        // 3.设置tableView的header
        self.tableView.mj_header = header
        // 4.进入刷新状态
        tableView.mj_header.beginRefreshing()

    }
    fileprivate func setupFooterView() {
    
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadMoreStatuses))
    }
    
    fileprivate func setupTipLabel() {
    
        navigationController?.navigationBar.insertSubview(tipLab, at: 0)
        tipLab.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 32)
        tipLab.backgroundColor = UIColor.orange
        tipLab.textColor = UIColor.white
        tipLab.font = UIFont.systemFont(ofSize: 14)
        tipLab.textAlignment = .center
        tipLab.isHidden = true
    }
    
    fileprivate func setupNatifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.showPhotoBrowser(_:)), name: NSNotification.Name(rawValue: ShowPhotoBrowserNote), object: nil)
    }
}

//MARK:- 事件的点击
extension HomeViewController {
  
    @objc fileprivate func leftBtnClick() {
    
        DLog("点击的是左边的 btn")
    }
    
    @objc fileprivate func rightBtnClick() {
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
    
    @objc fileprivate func showPhotoBrowser(_ note : Notification) {
        // 0.取出数据
        let indexPath = note.userInfo![ShowPhotoBrowserIndexKey] as! IndexPath
        let picURLs = note.userInfo![ShowPhotoBrowserUrlsKey] as! [URL]
        
        // 1.创建控制器
        let photoBrowserVc = PhotoBrowserController(indexPath: indexPath, picURLs: picURLs)

        print(picURLs)
        // 2.以modal的形式弹出控制器
        present(photoBrowserVc, animated: true, completion: nil)
    }

}

//MARK:- 请求网络数据
extension HomeViewController {

    /// 加载最新的数据
    @objc fileprivate func loadNewStatuses() {
        loadStatuses(true)
    }
    
    // 加载更多数据
    @objc fileprivate func loadMoreStatuses() {
    
        loadStatuses(false)
    }
    
    fileprivate func loadStatuses(_ isNewData : Bool) {
    
        // 1.获取since_id/max_id
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = self.dataArr.first?.status?.mid ?? 0
        } else {
            max_id = self.dataArr.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        SVProgressHUD.show(withStatus: "正在加载...")
       NetworkTools.shareInstance.loadStatus(since_id, max_id: max_id) { (result, error) -> (Void) in
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
        
        //            guard let anyObject = try? JSONSerialization.data(withJSONObject: result ?? "", options: [])else {
        //                return
        //            }
        //            let jsonString = String(data: anyObject, encoding: .utf8)
        //
        //            print("*****---------%@_------***",jsonString ?? "")
        // 3.遍历微博对应的字典
        var tempViewModel = [StatusViewModel]()
        for statusDict in resultArray {
            let model = StatusModel(dict: statusDict)
            let viewModel = StatusViewModel(status: model)
            tempViewModel.append(viewModel)
        }
        
        // 4.将数据放入到成员变量的数组中
        if isNewData {
            self.dataArr = tempViewModel + self.dataArr
        } else {
            self.dataArr += tempViewModel
        }
        // 图片的缓存处理,拿到图片的宽高比
        self.cacheImages(viewModel: tempViewModel, isNewData: isNewData)
        
        }
    }
    
    fileprivate func cacheImages(viewModel: [StatusViewModel],isNewData: Bool) {
        //1. 使用 GCD 创建一个动画组
        let group = DispatchGroup()
        for viewModel in viewModel {
            for picURL in viewModel.picURLs {
                // 添加到一个组中
                group.enter()
                SDWebImageManager.shared().downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _, _) in
                    //3. 从组中移除
                    group.leave()

                })
            }
        }
        //回到主线程刷新表格
      group.notify(queue: DispatchQueue.main) {
        
        self.tableView.reloadData()
        //停止刷新
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
        
        if isNewData {
            //显示提示的lable
            self.showTipLabel(viewModel.count)
            }
        }
    }
    
    fileprivate func showTipLabel(_ count: Int) {
    
        tipLab.isHidden = false
        tipLab.text = count == 0 ? "没有新数据" : "\(count)条新微薄"
        
        //执行动画
        UIView.animate(withDuration: 1.0, animations: {
            self.tipLab.frame.origin.y = 44
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: { 
                self.tipLab.frame.origin.y = 10
            }, completion: { (_) in
                self.tipLab.isHidden = true
            })
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
