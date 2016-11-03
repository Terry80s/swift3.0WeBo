//
//  UserAccount.swift
//  WeBo
//
//  Created by Apple on 16/11/3.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {

    //MARK:- 定义属性
    //授权 account
    var access_token: String?
    //过期时间
    var expires_in: TimeInterval = 0.0 {
    
        didSet {
        
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    //用户 Id
    var uid: String?
    
    //过期时间
    var expires_date: NSDate?
    
    //昵称
    var screen_name: String?
    
    //用户的头像地址
    var avatar_large: String?
    
    
    
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
    
    
    //MARK: - 归档解档
    //解档方法
    required init?(coder aDecoder: NSCoder) {
      
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
    //归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
    }
}
