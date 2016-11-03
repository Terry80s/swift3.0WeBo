




//
//  UIButton-Extension.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

extension UIButton {
    
    /*
    这种扩展方法可以实现,但是不推荐使用
    //在 swift 中类方法是以 class 开头的方法,类似 OC 中+开头的方法
    class func createButton(imageName: String, bgImagename: String) -> UIButton {
        let btn = UIButton()
        
        btn.setBackgroundImage(UIImage(named: bgImagename), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: bgImagename+"_highlighted"), forState: .Selected)
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName+"_highlighted"), forState: .Selected)
        btn.sizeToFit()
        
        return btn
    }
 
 */
    
    //构造函数以 init 开头并且不需要写返回值
    //convenience : 便利 使用convenience修饰的构造函数叫做便利构造函数
    //遍历构造函数通常用在对系统的类进行构造函数的扩充时使用
    /*
     1.遍历构造函数通常都是写在 extension 里面
     2.遍历构造函数init 前面需要写convenience
     3.在遍历构造函数中需要明确调用 self.init()
     
     */
    convenience init(imageName: String, bgImageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: UIControlState())
        setImage(UIImage(named: imageName+"_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: UIControlState())
        setBackgroundImage(UIImage(named: bgImageName+"_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
    
    
}

