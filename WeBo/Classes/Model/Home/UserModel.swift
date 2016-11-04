//
//  UserModel.swift
//  WeBo
//
//  Created by Apple on 16/11/4.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    var screen_name: String?         //用户昵称
    var profile_image_url: String?   //用户的头像
    var verified_type: Int = -1      //用户的认证
    var mbrank: Int = 0              // 用户的会员等级

    //MARK:- 自定义构造函数
    init(dict: [String: Any]) {
        super.init()
    
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
