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
    fileprivate lazy var toolBarBottom: UIToolbar = UIToolbar()
    //MARK:- 系统回掉函数
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        setupToolsBarBottom()
        // 监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(ComposeViewController.keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    //MARK: - 释放函数
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        self.automaticallyAdjustsScrollViewInsets = true

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(ComposeViewController.closeItemBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(ComposeViewController.sendItemBtnClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.title = "发微博"
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView
        
//        textView.frame = CGRect(x: 8, y: 0, width: UIScreen.main.bounds.width-16, height: UIScreen.main.bounds.height-70)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(3)
        }
        textView.delegate = self
        view .addSubview(textView)
        
    }
    
    func setupToolsBarBottom() {
        view .addSubview(toolBarBottom)
        toolBarBottom.backgroundColor = UIColor.darkGray
        
        // 设置控件的 frame 
        toolBarBottom.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-44, width: UIScreen.main.bounds.width, height: 44)
        
        // 定义 toolBar中 titles
        let titleImgs = ["compose_toolbar_picture.png","compose_mentionbutton_background.png","compose_trendbutton_background.png","compose_emoticonbutton_background.png","compose_keyboardbutton_background.png"]
        
        // 遍历标题,创建 item
        var index = 0
        var tempItem = [UIBarButtonItem]()
        
        for titleImg in titleImgs {
            
             let imageNormal = UIImage(named: titleImg)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            
            let item = UIBarButtonItem(image: imageNormal, style: .plain, target: self, action: #selector(ComposeViewController.itemBtnClick(sender:)))
            
            item.tag = index
            index += 1
            //添加弹簧
            tempItem.append(item)
            tempItem.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        
        // 设置 toolBar的 item 数组
        tempItem.removeLast()
        toolBarBottom.items = tempItem
    }
}

//MARK:- 事件的监听
extension ComposeViewController {

    @objc fileprivate func closeItemBtnClick() {
    
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendItemBtnClick() {
    
    }
    
    //监听键盘的事件
    func keyboardWillChangeFrame(note: Notification) {
        
        print(note.userInfo ?? "")
        // 1.获取动画执行的时间
        let duration = note.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        // 2.获取键盘最终 Y值
        let endFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // 执行动画
//        UIView.animate(withDuration: duration) {
//            self.toolBarBottom.transform = self.toolBarBottom.transform.translatedBy(x: 0, y: -endFrame.size.height)
//        }
        
        
        
    }
    
    //toolbar的时间监听
    @objc func itemBtnClick(sender: UIBarButtonItem) {
    
        print(sender.tag)
    }
    
}

//MARK: - textView代理方法
extension ComposeViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        //hasText 系统提供的方法判断是否有没有内容
        self.textView.preloadLab.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
