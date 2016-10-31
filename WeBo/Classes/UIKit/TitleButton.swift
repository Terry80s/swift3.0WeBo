//
//  TitleButton.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    // MARK:- 重写init函数
    override init(frame: CGRect) {
        super.init(frame : frame)
        
        setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControlState())
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: UIControlState())
        sizeToFit()
    }
    
    // swift中规定:重写控件的init(frame方法)或者init()方法,必须重写init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
}
