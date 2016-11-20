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
    //当一个传入函数的闭包在函数执行结束之后才会被调用，这样的闭包就叫做逃逸闭包。如果一个函数的参数有一个逃逸闭包，可以在参数前加@escaping关键字来修饰。
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

    func loadStatus(_ since_id : Int, max_id : Int, finished:@escaping (_ result: [[String: Any]]?, _ error: Error?) -> (Void)) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        //设置参数
        let accessToken = (UserAccountViewModel.shareIntance.account?.access_token)!
        let parameters = ["access_token" : accessToken, "since_id" : "\(since_id)", "max_id" : "\(max_id)"]
        
        requestData(methodType: .get, urlString: urlString, parameters: parameters) { (result, error) -> (Void) in
            
            guard let resultDict = result as? [String: Any] else {
            
                finished(nil, error)
                return
            }
            
            finished(resultDict["statuses"] as? [[String: Any]], error)
        }
    }
}

// MARK:- 发送微博
extension NetworkTools {
    func sendStatus(statusText : String, isSuccess : @escaping (_ isSuccess : Bool) -> ()) {
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : (UserAccountViewModel.shareIntance.account?.access_token)!, "status" : statusText]
        
        // 3.发送网络请求
        requestData(methodType: .post, urlString: urlString, parameters: parameters) { (result, error) -> () in
            if result != nil {
                isSuccess(true)
            } else {
                isSuccess(false)
                print(error ?? "")
            }
        }
    }
}


// MARK:- 发送微博并且携带照片
extension NetworkTools {
    func sendStatus(statusText : String, image : UIImage, isSuccess : @escaping (_ isSuccess : Bool) -> ()) {
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/upload.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : (UserAccountViewModel.shareIntance.account?.access_token)!, "status" : statusText]
        
        // 3.发送网络请求
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                formData.appendPart(withFileData: imageData, name: "pic", fileName: "123.png", mimeType: "image/png")
            }

        }, progress: nil, success: { (_, _) in
            isSuccess(true)

        }, failure: { (_, error) in
            print(error)

        })
    }
}

