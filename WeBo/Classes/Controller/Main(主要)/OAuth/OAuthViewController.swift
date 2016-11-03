//
//  OAuthViewController.swift
//  WeBo
//
//  Created by Apple on 16/9/30.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SVProgressHUD
class OAuthViewController: UIViewController {

    //MARK:- 控件的属性
    @IBOutlet weak var webView: UIWebView!
    
    //MARK:- 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航网页的内容
        setupNavgationBar()
     
        //加载网页
        loadPage()
    }

}


//MARK:- UI界面相关
extension OAuthViewController {

    fileprivate func setupNavgationBar() {
    
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.closeItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "填充", style: .plain, target: self, action: #selector(OAuthViewController.fileItemClick))
        
        navigationItem.title = "登录页面"
    }
    
    //加载网页
    fileprivate func loadPage() {
    
        // 1.获取登录页面的 URLString
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        // 2.创建对应NSURL
        guard let url = URL(string: urlString) else {
            return
        }
        
        // 3.创建NSURLRequest对象
        let request = URLRequest(url: url as URL)
        
        // 4.加载 request 对象
        webView.loadRequest(request as URLRequest)
        
    }
}

//MARK:- 点击事件相关
extension OAuthViewController {

    @objc fileprivate func closeItemClick() {
    
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func fileItemClick() {
    
        DLog("填充账号")
        // 1.书写 JS 代码:
        let jsCode = "document.getElementById('userId').value='15515612997';document.getElementById('passwd').value='15515612997abc';"
        
        // 2.执行 js代码
        webView.stringByEvaluatingJavaScript(from: jsCode)

    }
    
    
}

//MARK:- webView 的代理方法
extension OAuthViewController : UIWebViewDelegate {

    // webView 开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    // webView 网页加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // webView网页加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showError(withStatus: "加载错误")
    }

    // 当准备加载某一个页面时,会执行该方法
    // 返回值: true -> 继续加载该页面 false -> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 1.获取加载网页的 URL
        guard let url = request.url else {
            return true
        }
        
        // 2. 获取 URL 中的字符串
        let urlString = url.absoluteString
        
        
        // 3.判断该字符串是否包含 code
        guard urlString.contains("code=") else {
            return true
        }
        
        // 4.将 code 截取出来
        let code = urlString.components(separatedBy: "code=").last
        
        DLog("URLString=\(urlString)")
        DLog("code=\(code)")
        
        // 5. 请求 accessToken
        loadAccessToken(code!)
        return false
    }
}

//MARK:- 请求数据
extension OAuthViewController {

    fileprivate func loadAccessToken(_ code : String) {
    
        NetworkTools.shareInstance.loadAccessToken(code: code) { (result, error) -> (Void) in
            // 1.错误校验
            if error != nil {
                DLog(error)
                return
            }
            // 2.拿到结果
            guard result != nil else {
            
                return
            }
            DLog(result)
            // 3.将字典转成模型对象
            let account = UserAccount(dict: result!)
        }
    }
}




