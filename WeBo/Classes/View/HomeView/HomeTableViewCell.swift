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
class HomeTableViewCell: UITableViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var verifiedImgView: UIImageView!
    @IBOutlet weak var vipImgView: UIImageView!
    @IBOutlet weak var screenNameLable: UILabel!
    @IBOutlet weak var timeImgLable: UILabel!
    @IBOutlet weak var sourceLable: UILabel!
    @IBOutlet weak var contentLable: UILabel!
    
    //MARK: - 约束属性
    @IBOutlet weak var contentWitdhConns: NSLayoutConstraint!
    
    //MARK: - 自定义属性
    var viewModel: StatusViewModel? {
        didSet {
        
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
            
            //设置会员昵称的颜色
            screenNameLable.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        contentWitdhConns.constant = UIScreen.main.bounds.width - 2 * edgeMargin
    }

    
}
