//
//  VisitorView.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/16.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    //MARK:- 控件的属性
    
    @IBOutlet weak var rotationView: UIImageView!
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipLable: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK:- 提供快速通过 xib 创建的类方法
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)!.first as! VisitorView
    }
    
    //MARK:- 自定义函数
    func setupVisitorViewInfo(_ iconName: String, titlt: String) {
        
        iconView.image = UIImage(named: iconName)
        tipLable.text = titlt
        rotationView.isHidden = true
    }
    
    func addRotationAnimation() {
        
        //1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        //2.设置动画的属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5.0
        rotationAnim.isRemovedOnCompletion = false
        //3.将动画 Layer中
        rotationView.layer.add(rotationAnim, forKey: nil)
    }
}

