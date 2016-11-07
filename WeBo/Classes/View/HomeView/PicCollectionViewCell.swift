//
//  PicCollectionViewCell.swift
//  
//
//  Created by Apple on 16/11/7.
//
//

import UIKit
import SDWebImage
class PicCollectionViewCell: UICollectionViewCell {

    //定义属性
    @IBOutlet weak var iconImgView: UIImageView!
    
    var picURL: URL? {
    
        didSet {
        
            guard let picURL = picURL else {
                return
            }
            iconImgView.sd_setImage(with: picURL, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    
    //MARK:- 系统的回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
