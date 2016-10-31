//
//  UIBarItem-Extension.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    //两种方法
    //第一种
    /*
    convenience init(imageName: String) {
        self.init()
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName+"_highlighted"), forState: .Selected)
        btn.sizeToFit()

        self.customView = btn
        
    }
     */
    //第二中

    convenience init(target:AnyObject?,action:Selector,image:String) {
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: image), for: UIControlState())
        btn.setImage(UIImage(named: image + "_highlighted"), for: UIControlState.highlighted)
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        self.init(customView:btn)
    }
    
}
