//
//  PicPickerViewCell.swift
//  WeBo
//
//  Created by Apple on 16/11/14.
//  Copyright © 2016年 叶炯. All rights reserved.
//

/**
 代理和通知都用了一遍
 */
import UIKit

// 1.定义一个协议
protocol PicPickerViewCellDelegate {
    
    func didpickerDeleteBtnClick(sender: UIButton,picImage: UIImage)
}

class PicPickerViewCell: UICollectionViewCell {

    //MARK:- 控件的属性
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var removePhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK:- 定义属性

    // 2.声明一个委托代理
    var delegate: PicPickerViewCellDelegate?
    
    var image: UIImage? {
    
        didSet {
            if image != nil {
                imageView.image = image
                addPhotoBtn.isUserInteractionEnabled = false
                removePhotoBtn.isHidden = false
            } else {
                imageView.image = nil
                addPhotoBtn.isUserInteractionEnabled = true
                removePhotoBtn.isHidden = true
            }
        }
    }
    
    //MARK:- 事件的监听

    @IBAction func deleteBtnClick(_ sender: UIButton) {
      
        // 3.调用代理
        guard imageView.image != nil else {
            return
        }
        delegate?.didpickerDeleteBtnClick(sender: sender, picImage: imageView.image!)
    }
    
    @IBAction func addPhotoClick(_ sender: UIButton) {
        
        //设计到多层传递,使用通知比使用代理闭包好
        NotificationCenter.default.post(name: Notification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
    }
}
