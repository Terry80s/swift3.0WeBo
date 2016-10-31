
//
//  PopoverAnimator.swift
//  WeBo
//
//  Created by 叶炯 on 16/9/17.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {

    //MARK: - 属性
    fileprivate var isPersent: Bool = false
    
    var presentedFrame: CGRect = CGRect.zero
    
    //闭包回调
    var callBack: ((_ persented: Bool) -> ())?
    
    //MARK: - 自定义构造函数
    //注意:如果自定义了一个构造函数,但是没有对默认构造函数 init()进行重写,那么自定义的构造函数会覆盖默认的 init() 构造函数
    init(callBack: @escaping (_ persented: Bool) -> ()) {
      
        self.callBack = callBack
    }
    
    
}

//MARK:- 设置自定义转场动画代理方法
extension PopoverAnimator: UIViewControllerTransitioningDelegate {
    
    //目的: 改变弹出 view 的fream
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentation = YJPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presentedFrame = presentedFrame
        return presentation
    }
    
    //目的: 自定义弹出的动画 返回是一个协议
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPersent = true
        //调用闭包
        callBack!(isPersent)
        return self
    }
    
    //目的: 自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPersent = false
        //调用闭包
        callBack!(isPersent)
        return self
    }
    
}

//MARK: - 弹出和消失动画代理的方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning    {
    
    //动画持续的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //获取"转场的上下文": 可以通过转场上下文获取弹出的 View 和消失的 View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPersent ? animateTransitionPersentView(transitionContext) : animateTransitionDismissView(transitionContext)
    }
    
    //自定义弹出动画
    fileprivate func animateTransitionPersentView(_ transitionContext: UIViewControllerContextTransitioning) {
        
        //1.获取弹出的 view
        //UITransitionContextToViewKey 获取消失的 view
        //UITransitionContextFromViewKey 获取弹出的 View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        //2. 将弹出的 View 添加到 containerView 中
        transitionContext.containerView.addSubview(presentedView)
        
        //3.执行动画
        //执行动画的比例
        presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        //设置锚点
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            //回到最初的位置
            presentedView.transform = CGAffineTransform.identity
        }, completion: { (_) in
            //必须告诉上下文,已完成动画
            transitionContext.completeTransition(true)
        }) 
        
    }
    
    //自定义消失动画
    fileprivate func animateTransitionDismissView(_ transitionContext: UIViewControllerContextTransitioning) {
        
        //1.获取消失的 view
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        //2.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.001)
        }, completion: { (_) in
            dismissView?.removeFromSuperview()
            //必须告诉上下文,已完成动画
            transitionContext.completeTransition(true)
        }) 
        
    }
    
}

