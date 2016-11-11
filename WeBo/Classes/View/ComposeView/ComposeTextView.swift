//
//  ComposeTextView.swift
//  WeBo
//
//  Created by Apple on 16/11/10.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SnapKit
class ComposeTextView: UITextView {

    //MARK:- 懒加载属性
    lazy var preloadLab: UILabel = UILabel()
    
    //MARK:- 自定义构造函数
    required init?(coder aDecoder: NSCoder) {
       
        super.init(coder: aDecoder)
        
        setupUI()
    }
 
    

}

extension ComposeTextView {

    fileprivate func setupUI() {
    
        // 1.添加子控件
        addSubview(preloadLab)
        
        // 2.设置 frame
        preloadLab.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        
        // 3.设置属性
        preloadLab.textColor = UIColor.lightGray
        preloadLab.font = font
        
        // 4.设置文字
        preloadLab.text = "分享新鲜事..."
        
        // 5.设置内容内边距
        textContainerInset = UIEdgeInsetsMake(6, 7, 0, 7)
        
    }
}
