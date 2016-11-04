//
//  UserAccountViewModel.swift
//  
//
//  Created by 叶炯 on 2016/11/3.
//
//

import UIKit

class UserAccountViewModel {

    //MARK: - 将类设置为单利
    static let shareIntance: UserAccountViewModel = UserAccountViewModel()
    
    // MARK:- 定义属性
    var account : UserAccount?
    
    //计算属性
    var accountPath: String {
    
        // MARK:- 计算属性
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
         return accountPath + "/account.plist"
    }
    
    var isLogin: Bool {
    
        if account == nil  {
            
            return false
        }
        guard let expiresDate = account?.expires_date  else {
            return false
            
        }
        
        return expiresDate.compare(NSDate() as Date) == ComparisonResult.orderedDescending
    }
    
    
    // MARK:- 重写init()函数
    init() {
        print(accountPath)
        // 1.从沙盒中读取中归档的信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount

    }
    
}
