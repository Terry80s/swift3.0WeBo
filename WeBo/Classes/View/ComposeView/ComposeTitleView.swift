//
//  ComposeTitleView.swift
//  WeBo
//
//  Created by Apple on 16/11/11.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SnapKit
class ComposeTitleView: UIView {

    
    //MARK:- 懒加载属性
    
    fileprivate lazy var titleLab: UILabel = UILabel()
    fileprivate lazy var screenNameLab: UILabel = UILabel()
    
    //MARK:- 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

}

//MARK:- 设置 UI界面相关
extension ComposeTitleView {

    fileprivate func setupUI() {
    
        addSubview(titleLab)
        addSubview(screenNameLab)
  
        
        titleLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
  
        screenNameLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLab.snp.centerX)
            make.top.equalTo(titleLab.snp.bottom).offset(3)
        }
        titleLab.font = UIFont.systemFont(ofSize: 16)
        screenNameLab.font = UIFont.systemFont(ofSize: 14)
        screenNameLab.textColor = UIColor.lightGray
        
        titleLab.text = "发微博"
        screenNameLab.text = UserAccountViewModel.shareIntance.account?.screen_name
    }
}
