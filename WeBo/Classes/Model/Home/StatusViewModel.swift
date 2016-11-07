//
//  StatusViewModel.swift
//  WeBo
//
//  Created by Apple on 16/11/4.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {

    //MARK:- 定义属性
    var status: StatusModel?
    
    //MARK:- 对数据处理的属性
    var sourceText : String?    //截取后的微博来源
    var createAtText : String?  //格式化后的微博的时间
    
    var verifiedImage: UIImage? //用户认证
    var vipImage: UIImage?      //vipImg
    
    var profileURL: NSURL? //处理头像
    var picURLs : [URL] = [URL]()   // 处理微博配图的数据

    
    init(status: StatusModel) {
       
        self.status = status
        // 1.对来源处理
        // nil 值校验
        if let source = status.source, source != "" {
            // 对来源的字符串进行处理
            //获取字符串的长度
            let startIndex = (source as NSString).range(of: ">").location+1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            // 截取字符串
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
        // 2.处理时间
        // 1. nil 值校验
        if let created_at = status.created_at {
            // 对时间的处理
            createAtText = NSDate.createDateString(createAtStr: created_at)
        }
        
        // 3.用户认证处理
        let verified_type = status.user?.verified_type ?? -1
        
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }

        // 4.用户等级处理
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        // 5.处理头像的请求
        let profileUrlSring = status.user?.profile_image_url ?? ""
        profileURL = NSURL(string: profileUrlSring)
        
        // 6. 处理配图数据
        if let picUrlArr = status.pic_urls {
            for picURLDict in picUrlArr {
                guard let picURLString = picURLDict["thumbnail_pic"] else {
                    continue
                }
                picURLs.append(URL(string: picURLString)!)
            }
        }
    }
}
