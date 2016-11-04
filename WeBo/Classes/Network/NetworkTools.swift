//
//  NetworkTools.swift
//  WeBo
//
//  Created by Apple on 16/11/3.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import AFNetworking

//定义枚举类型
enum RequestType : String {
    case get = "GET"
    case post = "POST"
}

class NetworkTools: AFHTTPSessionManager {

    //let 是线程安全的
    //通过闭包创建对象
    static let shareInstance : NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
}

//MARK:- 封装网络数据
extension NetworkTools {

    //逃逸闭包 @escaping
    func requestData(methodType: RequestType, urlString: String, parameters: [String: Any], finished: @escaping (_ result : Any?, _ error : Error?) -> (Void)) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask,result: Any?) -> Void in
            finished(result, nil)
            
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : URLSessionDataTask?,error : Error) -> Void in
            finished(nil, error)
        }
        
        // 3.发送网络请求
        if methodType == .get {
           
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            
        } else {
           
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
}

//MARK:- 请求数据
extension NetworkTools {

    func loadAccessToken(code: String, finished: @escaping (_ result: [String: Any]?, _ error: Error?) -> (Void)) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = ["client_id": app_key, "client_secret": app_secret, "grant_type": "authorization_code", "code": code, "redirect_uri": redirect_uri]

       requestData(methodType: .post, urlString: urlString, parameters: parameters) { (result, error) -> (Void) in
        
        finished(result as? [String : Any], error)
        }
    }
}

//MARK: - 请求用户信息
extension NetworkTools {

    func loadUserInfo(access_token: String, uid: String, finished: @escaping (_ result: [String: Any]?, _ error:Error?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token": access_token, "uid": uid]
        
        requestData(methodType: .get, urlString: urlString, parameters: parameters) { (result, error) -> (Void) in
            finished(result as? [String : Any], error)
        }
    }
}

//MARK:- 请求首页数据
extension NetworkTools {

    func loadStatus(finished:@escaping (_ result: [[String: Any]]?, _ error: Error?) -> (Void)) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameter = ["access_token": UserAccountViewModel.shareIntance.account?.access_token]
        
        requestData(methodType: .get, urlString: urlString, parameters: parameter) { (result, error) -> (Void) in
            
            guard let resultDict = result as? [String: Any] else {
            
                finished(nil, error)
                return
            }
            
            finished(resultDict["statuses"] as? [[String: Any]], error)
        }
    }
}
