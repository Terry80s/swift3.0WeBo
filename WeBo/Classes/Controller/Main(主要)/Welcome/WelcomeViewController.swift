//
//  WelcomeViewController.swift
//  WeBo
//
//  Created by 叶炯 on 2016/11/3.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SDWebImage
class WelcomeViewController: UIViewController {

    //MARK:- 设置属性
    @IBOutlet weak var UserHeaderImg: UIImageView!
    @IBOutlet weak var UserNickname: UILabel!
    
    @IBOutlet weak var UserHeraderImgBottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //使用xib设置圆角 需要使用 KVC 监听属性的的值 layer.cornerRadius 类型为 number layer.masksToBounds 类型了 Bool
        let profileURLString = UserAccountViewModel.shareIntance.account?.avatar_large
        //??: 如果??前面的可选类型有值,那么将前面的可选类型解包并且赋值
        //如果??前面的可选类型为 nil那么直接使用后面的值
        let profileURL = URL(string: profileURLString ?? "")
        
        UserHeaderImg.sd_setImage(with: profileURL, placeholderImage: UIImage(named: "avatar_default"))
        UserNickname.text = UserAccountViewModel.shareIntance.account?.screen_name ?? "欢迎回来"
        
        // 改变约束的值
        UserHeraderImgBottom.constant = UIScreen.main.bounds.height - 2_00
        
        // 执行动画
        // Damping : 阻力系数,阻力系数越大,弹动的效果越不明显 0~1
        // initialSpringVelocity : 初始化速度
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 6.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = MainViewController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
