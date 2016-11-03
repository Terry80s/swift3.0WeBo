//
//  UserAccount.swift
//  WeBo
//
//  Created by Apple on 16/11/3.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class UserAccount: NSObject {

    //MARK:- 定义属性
    //授权 account
    var access_token: String?
    //过期时间
    var expires_in: TimeInterval = 0.0
    //用户 Id
    var uid: String?
    
    //MARK:- 自定义构造函数
    //使用 KVC 解析字典
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    //MARK:- 重写 description属性
    override var description: String {
    
//        return"account\(access_token)"
        return dictionaryWithValues(forKeys: ["access_token", "expires_in", "uid"]).description
    }
    
}
