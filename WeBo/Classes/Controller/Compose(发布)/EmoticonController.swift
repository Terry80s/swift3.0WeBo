//
//  EmoticonController.swift
//  09-表情键盘
//
//  Created by xiaomage on 16/4/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

private let EmoticonCell = "EmoticonCell"

class EmoticonController: UIViewController {
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: EmoticonCollectionViewLayout())
    fileprivate lazy var toolBar : UIToolbar = UIToolbar()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}


// MARK:- 设置UI界面内容
extension EmoticonController {
    private func setupUI() {
        // 1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        collectionView.backgroundColor = UIColor.purpleColor()
        toolBar.backgroundColor = UIColor.darkGrayColor()
        
        // 2.设置子控件的frame
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tBar" : toolBar, "cView" : collectionView]
        var cons = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cView]-0-[tBar]-0-|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        // 3.准备collectionView
        prepareForCollectionView()
        
        // 4.准备toolBar
        prepareForToolBar()
    }
    
    private func prepareForCollectionView() {
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: EmoticonCell)
        collectionView.dataSource = self
    }
    
    private func prepareForToolBar() {
        // 1.定义toolBar中titles
        let titles = ["最近", "默认", "emoji", "浪小花"]
        
        // 2.遍历标题,创建item
        var index = 0
        var tempItems = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .Plain, target: self, action: "itemClick:")
            item.tag = index
            index++
            
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
        }
        
        // 3.设置toolBar的items数组
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orangeColor()
    }
    
    @objc private func itemClick(item : UIBarButtonItem) {
        print(item.tag)
    }
}


extension EmoticonController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(EmoticonCell, forIndexPath: indexPath)
        
        // 2.给cell设置数据
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.redColor() : UIColor.blueColor()
        
        return cell
    }
}




class EmoticonCollectionViewLayout : UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        // 1.计算itemWH
        let itemWH = UIScreen.mainScreen().bounds.width / 7
        
        // 2.设置layout的属性
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        
        // 3.设置collectionView的属性
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        let insetMargin = (collectionView!.bounds.height - 3 * itemWH) / 2
        collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
    }
}








