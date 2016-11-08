//
//  HomeTableViewCell.swift
//  WeBo
//
//  Created by Apple on 16/11/4.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin: CGFloat = 12
private let itemMargin: CGFloat = 10

class HomeTableViewCell: UITableViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var verifiedImgView: UIImageView!
    @IBOutlet weak var vipImgView: UIImageView!
    @IBOutlet weak var screenNameLable: UILabel!
    @IBOutlet weak var timeImgLable: UILabel!
    @IBOutlet weak var sourceLable: UILabel!
    @IBOutlet weak var contentLable: UILabel!
    @IBOutlet weak var picView: PicCollectionView!
    @IBOutlet weak var retweetedContentLabel: UILabel!
    @IBOutlet weak var retweetedBgView: UIView!
    
    //MARK: - 约束属性
    @IBOutlet weak var contentWitdhConns: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var retweetedContentLabelTopCons: NSLayoutConstraint!
    
    //MARK: - 自定义属性
    var viewModel: StatusViewModel? {
        didSet {
        
            // nil 校验
            guard let viewModel = viewModel else {
                return
            }
            
            iconImgView.sd_setImage(with: viewModel.profileURL as URL!, placeholderImage: UIImage(named: "avatar_default_small"))
            
          
            verifiedImgView.image = viewModel.verifiedImage
            
            vipImgView.image = viewModel.vipImage
            
            screenNameLable.text = viewModel.status?.user?.screen_name
            
            timeImgLable.text = viewModel.createAtText
            
            sourceLable.text = viewModel.sourceText
            
            contentLable.text = viewModel.status?.text
            
            // 设置会员昵称的颜色
            screenNameLable.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            // 计算 picView的宽度和高度的约束
            let picViewSize = calculatePicViewSize(count: viewModel.picURLs.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
            
            // 将picURL数据传递给picView
            picView.picURL = viewModel.picURLs
            
            // 设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, let retweetedText = viewModel.status?.retweeted_status?.text {
                    
                    retweetedContentLabel.text = "@" + "\(screenName) :" + retweetedText
                    // 设置转发正文距离顶部的约束
                    retweetedContentLabelTopCons.constant = 15
                }
                // 2.设置背景显示
                retweetedBgView.isHidden = false
            }else {
                // 设置转发微博的正文
                retweetedContentLabel.text = nil
                // 设置背景显示
                retweetedBgView.isHidden = true
                // 3.设置转发正文距离顶部的约束
                retweetedContentLabelTopCons.constant = 0

            }
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        contentWitdhConns.constant = UIScreen.main.bounds.width - 2 * edgeMargin
       
    }
}

//MARK:- 计算方法
extension HomeTableViewCell {

    func calculatePicViewSize(count: Int) -> CGSize {
    
        // 1.没有配图
        if count == 0 {
            
            //解决约束重复的问题
            picViewBottomCons.constant = 0
            return CGSize.zero
        }
        
        // 有配图需要改约束有值
        picViewBottomCons.constant = 10
        
        // 2.取出picView对应的layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout

        // 3.单张配图比例加载图片
        if count == 1 {
            // 取出图片
            let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: viewModel?.picURLs.last?.absoluteString)
            
            // 2.设置一张图片是layout的itemSize
            layout.itemSize = CGSize(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
            
            return CGSize(width: (image?.size.width)! * 2, height: (image?.size.height)! * 2)
        }
        
        // 4.计算出来 imageViewWH
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
        
        // 5.设置其他张图片时layout的itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        // 6.四张图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        // 7.其他张配图
        // 7.1.计算行数
        let rows = CGFloat((count - 1) / 3 + 1)
        
        // 7.2.计算picView的高度
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        
        // 7.3.计算picView的宽度
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
        
    }
}
