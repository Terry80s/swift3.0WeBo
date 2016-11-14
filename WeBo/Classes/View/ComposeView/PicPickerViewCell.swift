//
//  PicPickerViewCell.swift
//  WeBo
//
//  Created by Apple on 16/11/14.
//  Copyright © 2016年 叶炯. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addPhotoClick(_ sender: UIButton) {
        
        //设计到多层传递,使用通知比使用代理闭包好
        NotificationCenter.default.post(name: Notification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
    }
}
