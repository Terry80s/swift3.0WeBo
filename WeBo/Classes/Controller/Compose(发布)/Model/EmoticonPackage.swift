//
//  EmoticonPackage.swift
//  09-表情键盘
//
//  Created by xiaomage on 16/4/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    var emoticons : [Emoticon] = [Emoticon]()
    
    init(id : String) {
        // 1.最近分组
        if id == "" {
            return
        }
        
        // 2.根据id拼接info.plist的路径
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        // 3.根据plist文件的路径读取数据 [[String : String]]
        let array = NSArray(contentsOfFile: plistPath)! as! [[String : String]]
        
        // 4.遍历数组
        for var dict in array {
            if let png = dict["png"] {
                dict["png"] = id + "/" + png
            }
            
            emoticons.append(Emoticon(dict: dict))
        }
    }
}
